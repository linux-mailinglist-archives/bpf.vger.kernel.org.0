Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABFC5A1677
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 18:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiHYQOz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 12:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiHYQOy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 12:14:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1441CFE3
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 09:14:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id x14-20020a17090a8a8e00b001fb61a71d99so5450552pjn.2
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 09:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc;
        bh=mw212yvPRnXeLb2w2KnA5nqe8QeHOTqKwCroqPRjVJ0=;
        b=icwnomgIUZ3BnbCIM8D0YZIJ14e5Bh9n+0UMQqlG1ZZwBYKFkK6ztD9EY5ESKV9SYq
         2vQdVPk95lvgoHcx48gyB0P4duwa7KkueX74MLGbeBM0V6W0BAn6otfYbQXCPWgxIlsK
         19RrgJ+jBGuGLeldLJ7IbjthtArPT93OP31IC+z5pHfXVQk1cIwbj59tqDn5lxHTwiw6
         t8vJPnHitkAxEV+oPlwv/ZFB1ijCEusMxOTfsRBAQWtYHy/+oCWX2l3mvipJUok+IciE
         co5Cl53A0Mc5s5PNTgqyfWikMPdoK3eKQVfu6gJnultsqztl4PUm/Ertgua+TmIKAoJ+
         6X3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc;
        bh=mw212yvPRnXeLb2w2KnA5nqe8QeHOTqKwCroqPRjVJ0=;
        b=iVqwl3L5DzoykCvYtL9gdxDZxpdEBw8YmNL1FN07iVvtuS9wLr14Ctwdj7yz7rllWm
         3XaAOcvMmW2ELAIRMr9Zjx8cxmvwJ5DLiOJl9HeVMddoSMq6PWSyU6rDD87i8WvZJN31
         lFZLTjxlaqaVtL1ok5cyuF7O+/4T48lASUByTGEMuJ663NZThdf9XAVFycBl+XNwnVvV
         lzOoKjOzJa4pfFY0yqvP3vjn0/yp4A0sabYi8s/wgq/4SzZfTCCvlvNB0oaHYLqXTVuL
         ojxyyLBUq1Bbl+WENLWgPAUdWQUGmDoIcrzmV3jU/GiA16jUiorOqSe98U/zeW2m8Jec
         RRfw==
X-Gm-Message-State: ACgBeo0F74MI8ldGzjzGpfr7BC+VjLBNtNOEukkQjnZHiYVAdpcEbmVn
        BsIzZh9suPY/nFdWLxlPxME=
X-Google-Smtp-Source: AA6agR71lRl7luNOaSnSCUdGqxJol9/+5R+DKr3JQcQuMQ7HhJn8WEaEuMiRb/rCDdgRW64BW142PQ==
X-Received: by 2002:a17:90a:3c89:b0:1fa:acc2:bafe with SMTP id g9-20020a17090a3c8900b001faacc2bafemr14738777pjc.84.1661444092781;
        Thu, 25 Aug 2022 09:14:52 -0700 (PDT)
Received: from localhost ([98.97.36.33])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090a6e0600b001f1f5e812e9sm3846671pjk.20.2022.08.25.09.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:14:52 -0700 (PDT)
Date:   Thu, 25 Aug 2022 09:14:50 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Shmulik Ladkani <shmulik@metanetworks.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Message-ID: <63079ffa3f2d_12460b208d0@john.notmuch>
In-Reply-To: <20220824044117.137658-2-shmulik.ladkani@gmail.com>
References: <20220824044117.137658-1-shmulik.ladkani@gmail.com>
 <20220824044117.137658-2-shmulik.ladkani@gmail.com>
Subject: RE: [PATCH v5 bpf-next 1/4] bpf: Add 'bpf_dynptr_get_data' helper
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Shmulik Ladkani wrote:
> The task of calculating bpf_dynptr_kern's available size, and the
> current (offset) data pointer is common for BPF functions working with
> ARG_PTR_TO_DYNPTR parameters.
> 
> Introduce 'bpf_dynptr_get_data' which returns the current data
> (with properer offset), and the number of usable bytes it has.
> 
> This will void callers from directly calculating bpf_dynptr_kern's
> data, offset and size.
> 
> Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
> ---
> v5:
> - fix bpf_dynptr_get_data's incorrect usage of bpf_dynptr_kern's size
>   spotted by Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/bpf.h  | 1 +
>  kernel/bpf/helpers.c | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 99fc7a64564f..d84d37bda87f 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2577,6 +2577,7 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
>  		     enum bpf_dynptr_type type, u32 offset, u32 size);
>  void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
>  int bpf_dynptr_check_size(u32 size);
> +void *bpf_dynptr_get_data(struct bpf_dynptr_kern *ptr, u32 *avail_bytes);
>  
>  #ifdef CONFIG_BPF_LSM
>  void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index fc08035f14ed..96ff93941cae 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1427,6 +1427,14 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
>  	bpf_dynptr_set_type(ptr, type);
>  }
>  
> +void *bpf_dynptr_get_data(struct bpf_dynptr_kern *ptr, u32 *avail_bytes)
> +{
> +	if (!ptr->data)
> +		return NULL;
> +	*avail_bytes = bpf_dynptr_get_size(ptr);
> +	return ptr->data + ptr->offset;
> +}
> +
>  void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr)
>  {
>  	memset(ptr, 0, sizeof(*ptr));
> -- 
> 2.37.2
> 

As a bit of an addmitedly nitpick I just wonder if having the avail_bytes
passed through like this is much use anymore? For example,

+BPF_CALL_3(bpf_skb_set_tunnel_opt_dynptr, struct sk_buff *, skb,
+	   struct bpf_dynptr_kern *, ptr, u32, len)
+{
+	const u8 *from;
+	u32 avail;
+
-       if (!ptr->data)
-		return -EFAULT;
-       avail = bpf_dynptr_get_size(ptr)
+	from = bpf_dynptr_get_data(ptr, &avail);
+	if (unlikely(len > avail))
+		return -EINVAL;
+	return __bpf_skb_set_tunopt(skb, from, len);
+}
+

seems just about as compact to me and then drop the null check from the
helper so we have a bpf_dynptr_get_data(*ptr) that just does the
data+offset arithmatic. Then it could also be used in a few other
spots where that calculation seems common.

I find it easier to read at least and think the helper would get
more use, also land it in one of the .h files. And avoids bouncing
avail around.

Bit of a gripe but what do you think?
