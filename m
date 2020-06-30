Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EE620F3CE
	for <lists+bpf@lfdr.de>; Tue, 30 Jun 2020 13:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733136AbgF3LuB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Jun 2020 07:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgF3LuA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Jun 2020 07:50:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6031BC03E979
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 04:50:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so16807271wrw.1
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2020 04:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hm99DwMfRW6Yrn3tUagzkyRAZ9V3WiaXuRVl4bieKDk=;
        b=c/i+r8l16IvmJHjNCI6NSEnbnhhTryuHilmSuq9nRPKgVxnTS2uVAk6mFFhrjesy/N
         cD3AeBuT0MGPVc1Z4atrCHi4kpXXFvvY6taRE2W244YMvI5fxjwNF2u2+Ue4P6qNoNzX
         VQ9gDQ8v65t9lJ6EcyaufWQIC5CyMz3j0Mme0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hm99DwMfRW6Yrn3tUagzkyRAZ9V3WiaXuRVl4bieKDk=;
        b=Koi/hwjtAEU0x8P4KpCUUiuuBDZhJ8ywV1JYXBAQn2lzyJjt/lcOezf3CwJCnwuQPs
         gI1+507dzyWG2kGHp4QJ054TuTiNTqHwasfYw3sMH9jhAR3jzZH6BLeuggrHgvTg7x2h
         upYkVQBJTO8nXp4RkkL3eHQRSalD1N7JMSgK/lTOhe5DxAx/p6wEVpYa4HaOQQtI/Gn8
         C3RxMOZ/wq7sFd3rnvuiadTzjwa44j4xjUvgyejmhm276Zz9YTTScAVD7mrxIhSHNrTv
         iqK0kuQIf6fdE4mpF+7WtdbvT/igO4B7RoPuUpu8Wdh1j/D5m1waIOjPSeRJh57vnKlc
         /rkw==
X-Gm-Message-State: AOAM533VCQLgiiylm0Amf6nLk89RRsFu/ILxV5XOUg+XJU5sPMXM/TSp
        Us/RF69Qes004MAnXx3ZOICcKw==
X-Google-Smtp-Source: ABdhPJzHOV39ukk2h81FYtYP2PJLbg+uZqHvfmTlT2Zf2OBkJDS4/55jtC5jQc2CYfF2o8W/1Gc1kQ==
X-Received: by 2002:adf:f9c8:: with SMTP id w8mr21133678wrr.354.1593517799060;
        Tue, 30 Jun 2020 04:49:59 -0700 (PDT)
Received: from google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id c5sm3248089wmb.24.2020.06.30.04.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 04:49:58 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Tue, 30 Jun 2020 13:49:56 +0200
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     KP Singh <kpsingh@chromium.org>, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v2 2/4] bpf: Implement bpf_local_storage for
 inodes
Message-ID: <20200630114956.GA421824@google.com>
References: <20200617202941.3034-1-kpsingh@chromium.org>
 <20200617202941.3034-3-kpsingh@chromium.org>
 <20200619065245.t755bkffk6zleoi2@kafai-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619065245.t755bkffk6zleoi2@kafai-mbp.dhcp.thefacebook.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 18-Jun 23:52, Martin KaFai Lau wrote:
> On Wed, Jun 17, 2020 at 10:29:39PM +0200, KP Singh wrote:
> [ ... ]
> 
> > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > index af74712af585..8efd7562e3de 100644
> > --- a/include/linux/bpf_lsm.h
> > +++ b/include/linux/bpf_lsm.h
> > @@ -17,9 +17,24 @@
> >  #include <linux/lsm_hook_defs.h>
> >  #undef LSM_HOOK
> >  
> > +struct bpf_storage_blob {
> > +	struct bpf_local_storage __rcu *storage;
> > +};
> > +
> > +extern struct lsm_blob_sizes bpf_lsm_blob_sizes;
> > +
> >  int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> >  			const struct bpf_prog *prog);
> >  
> > +static inline struct bpf_storage_blob *bpf_inode(
> > +	const struct inode *inode)
> > +{
> > +	if (unlikely(!inode->i_security))
> > +		return NULL;
> > +
> > +	return inode->i_security + bpf_lsm_blob_sizes.lbs_inode;
> > +}
> > +
> >  #else /* !CONFIG_BPF_LSM */
> >  
> >  static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > @@ -28,6 +43,12 @@ static inline int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> >  	return -EOPNOTSUPP;
> >  }
> >  
> > +static inline struct bpf_storage_blob *bpf_inode_storage(
> This does not seem to match the newly added "bpf_inode()"
> above for the "CONFIG_BPF_LSM" case.
> 
> A typo?  May be a good idea to test compiling with !CONFIG_BPF_LSM.

Sorry about that, yeah it was a last minute lazy rename. Will
compile test the series with !CONFIG_BPF_LSM and !CONFIG_NET. Thanks.

> 
> > +	const struct inode *inode)
> > +{
> > +	return NULL;
> > +}
> > +
> >  #endif /* CONFIG_BPF_LSM */
> >  
> >  #endif /* _LINUX_BPF_LSM_H */
> > diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> > index a18ae82a298a..881e7954c956 100644
> > --- a/include/linux/bpf_types.h
> > +++ b/include/linux/bpf_types.h
> > @@ -101,6 +101,7 @@ BPF_MAP_TYPE(BPF_MAP_TYPE_HASH_OF_MAPS, htab_of_maps_map_ops)
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP, dev_map_ops)
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_DEVMAP_HASH, dev_map_hash_ops)
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_SK_STORAGE, sk_storage_map_ops)
> > +BPF_MAP_TYPE(BPF_MAP_TYPE_INODE_STORAGE, inode_storage_map_ops)
> sk_storage is under CONFIG_NET.
> 
> inode_storage should be CONFIG_BPF_LSM?

Thanks, updated.

- KP

> 
> >  #if defined(CONFIG_BPF_STREAM_PARSER)
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKMAP, sock_map_ops)
> >  BPF_MAP_TYPE(BPF_MAP_TYPE_SOCKHASH, sock_hash_ops)
