Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998286A9565
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 11:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCCKis (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Mar 2023 05:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCCKir (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Mar 2023 05:38:47 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469B2110
        for <bpf@vger.kernel.org>; Fri,  3 Mar 2023 02:38:46 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id ff4so1444573qvb.2
        for <bpf@vger.kernel.org>; Fri, 03 Mar 2023 02:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677839925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KcNmrcXDPnNiN/6vaAueSYp12HrPogUua710viCGfag=;
        b=jm8D5J3erNmYcncY9INsBxaBWIvrSlopWQSU4AkkF/QHEQE6s0MI6aOebkhY0FJ8iJ
         fQgQI8yao5F1BTstJs/tQt58kHElMF34TOeSe7M8/Yr1gUz01BeR/WXUExal+fF8Sauc
         oONFFRyrp/OpsDKbPkZBuJmDWanCE1K3sD7vukFIq+eUKUSE0bMudnn9ffFz8E0wqXYn
         DmhZ4P7/QShsY1K2HDE3fNQzbYPv8HjQrfkHKV38FVZtzqXBpsuYb9d5vIwdKUNTO+O0
         QlYAfu2rgu+AyegyjFNQDRvSqhMhIJkvp+wCkE+/rk+LPBvYhOekcWENUxen36/J7hmX
         pXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677839925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KcNmrcXDPnNiN/6vaAueSYp12HrPogUua710viCGfag=;
        b=cM3Kuk/1Q/NtekQUK/HqFTx0Mvqu+vLT6IOiVvaPpNdgLDltTSGp1YXqBcsYGrhs03
         GeK5WZNasUjIPqi4jbPa6WL/s2j8iWKQtz78s30rbga3Pfwt0FZNC6zMWlwo6PDffH0N
         Vquj8wSopRf5GJ9i0oQwcVE5s6ESFUbVHW4HfGv94i7OSbZDNfVuxHlJlmrMGq2DYRQ9
         9iW/55Uc6oSofEQH3dqcxTVJSh/sFUmLR+SvkCuONS4sk41BpTtTINY+G7xBNlWIn75M
         r7ywl3tgzUdl2fA19INMrPdIp6/lJ+Ij0r8e7I8uscGa37mw4yg1PSabM4ZWEIfygaQa
         a1rw==
X-Gm-Message-State: AO0yUKX3Oiyxtnuu2doPm0HdxQsLLLCkBR32KvQjE3+sUK1mRdA4+TLp
        Bo1Jz8/5D11PiBUdnEH+s9uxiybNMVA6vjUXy0A=
X-Google-Smtp-Source: AK7set9YUjD0cOP2gWmiqjA0SvUjPe9E/vtistDXFe/nxe+NXA8bzfGcM5v9t6NuCLi72V4JJIu00IdDFzaGRKDuX6k=
X-Received: by 2002:ad4:5a0e:0:b0:571:e9d3:24a9 with SMTP id
 ei14-20020ad45a0e000000b00571e9d324a9mr301205qvb.10.1677839925407; Fri, 03
 Mar 2023 02:38:45 -0800 (PST)
MIME-Version: 1.0
References: <20230227152032.12359-3-laoar.shao@gmail.com> <20230301025929.237985-1-houtao@huaweicloud.com>
In-Reply-To: <20230301025929.237985-1-houtao@huaweicloud.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 3 Mar 2023 18:38:09 +0800
Message-ID: <CALOAHbCJXMXpzA6ZEEXgTXcJUVzmWC1K52t3SaLorGevNRtUdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 02/18] bpf: lpm_trie memory usage
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, horenc@vt.edu,
        john.fastabend@gmail.com, jolsa@kernel.org, kafai@fb.com,
        kpsingh@kernel.org, sdf@google.com, songliubraving@fb.com,
        xiyou.wangcong@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 1, 2023 at 10:31=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Hi,
>
> > trie_mem_usage() is introduced to calculate the lpm_trie memory usage.
> > Some small memory allocations are ignored. The inner node is also
> > ignored.
> >
> > The result as follows,
> >
> > - before
> > 10: lpm_trie  flags 0x1
> >         key 8B  value 8B  max_entries 65536  memlock 1048576B
> >
> > - after
> > 10: lpm_trie  flags 0x1
> >         key 8B  value 8B  max_entries 65536  memlock 2291536B
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/lpm_trie.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
> > index d833496..e0ca08e 100644
> > --- a/kernel/bpf/lpm_trie.c
> > +++ b/kernel/bpf/lpm_trie.c
> > @@ -720,6 +720,16 @@ static int trie_check_btf(const struct bpf_map *ma=
p,
> >              -EINVAL : 0;
> >  }
> >
> > +static u64 trie_mem_usage(const struct bpf_map *map)
> > +{
> > +     struct lpm_trie *trie =3D container_of(map, struct lpm_trie, map)=
;
> > +     u64 elem_size;
> > +
> > +     elem_size =3D sizeof(struct lpm_trie_node) + trie->data_size +
> > +                         trie->map.value_size;
> > +     return elem_size * trie->n_entries;
> Need to use READ_ONCE(trie->n_entries) because all updates of n_entries a=
re protected by trie->lock and here it is a lockless read.

Indeed. Will change it in the next version.
Thanks for your review.

--=20
Regards
Yafang
