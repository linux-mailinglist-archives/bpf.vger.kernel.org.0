Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B317505EE7
	for <lists+bpf@lfdr.de>; Mon, 18 Apr 2022 22:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbiDRUdo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 16:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbiDRUdn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 16:33:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA8C1E3EF
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 13:31:02 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e62-20020a17090a6fc400b001d2cd8e9b0aso212043pjk.5
        for <bpf@vger.kernel.org>; Mon, 18 Apr 2022 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hSpqujF7ro4wcmY/2oAkHO0L78JHc2EOEcjF9P5xwHg=;
        b=XI7w+tgupKjDciDKLvOCv/EBZws63oLHYqHr2VkNNGxKf33m+M2+SPqZKTu/VNkjm9
         hQZs1+OPbOGlufJTa/S7t9E8q8a8cA0NSGWeDuRb9aZVpKhTKCa6IXUdOQwAyY4EUsOU
         cEHRZ4+aug0Xh5AMZPK+NfWfwuBZpEowuJ96Rzo9vRTLNlMkjCMPZqEZQS2ciz+FGiKN
         1llaoPwWXpIXYB/nDE5u14/qAlxXth6e+JVDdKEnucewBJHCVbAdWizzYb0jcDggdY5v
         pC2aEjoy3rWBNnjvTA9QAYcGVkKyQpkIXlhqWVrot/jeeBHYYCNQgLztlnwfKzDMYiJ1
         uoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hSpqujF7ro4wcmY/2oAkHO0L78JHc2EOEcjF9P5xwHg=;
        b=G5yjD/oMg7hKn+Ujx4zKKUfmJWh9C0Uc/MaJlwvk19g0VJ5GnRUNwH4eLI9YqDueZG
         Oks38q4+jn5P6pxGjSt1UFrc3AMtW2fuiQ5E+jJrz5gNCf67cdVuPbbEVlGwEGo2uK0b
         cAFgTWjBPM5pPV1/7ILfCovHL/K6fPhWwUFYOr6q89VRY2JMjn4y7ePIaiDYZBbSQjkX
         PEwuyFfUm/cTS0z1bFaqSws0/kmnzaAJmvjcAQXOxqPHoGtwezFwoWo1450h88aOgsyZ
         0TFc3LfBsNSQ9TEi1zGffABRdfpKmXIIPU7iJymzBi4jvupJIikvSEeiNm8w1Lf4fUN8
         343Q==
X-Gm-Message-State: AOAM5334HBILI6Vl/VjJW4xSm5ONYAxMyrRg+X86c/uyAPWuciASSsqF
        15+fFfFC4GrTYTVEOnqEz8APoU4vxqu5eQ==
X-Google-Smtp-Source: ABdhPJzV6WmHWPKJcdsrQnt6LpgjCurlyoTmj8ZatRTMv0BXfVmefZG6ow/AnopYDqQuOBDI4CNROQ==
X-Received: by 2002:a17:903:1247:b0:156:25b4:4206 with SMTP id u7-20020a170903124700b0015625b44206mr12468259plh.146.1650313861680;
        Mon, 18 Apr 2022 13:31:01 -0700 (PDT)
Received: from localhost ([112.79.143.4])
        by smtp.gmail.com with ESMTPSA id c2-20020aa781c2000000b0050a7ff01d2bsm3404275pfn.30.2022.04.18.13.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 13:31:01 -0700 (PDT)
Date:   Tue, 19 Apr 2022 02:01:08 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Ensure type tags precede modifiers
 in BTF
Message-ID: <20220418203108.zsyox6jr4k5al5yo@apollo.legion>
References: <20220406004121.282699-1-memxor@gmail.com>
 <20220406004121.282699-2-memxor@gmail.com>
 <47fe6f32-fe4d-2e1d-6297-36c30d8c6586@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47fe6f32-fe4d-2e1d-6297-36c30d8c6586@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 19, 2022 at 01:23:32AM IST, Yonghong Song wrote:
>
>
> On 4/5/22 5:41 PM, Kumar Kartikeya Dwivedi wrote:
> > It is guaranteed that for modifiers, clang always places type tags
> > before other modifiers, and then the base type. We would like to rely on
> > this guarantee inside the kernel to make it simple to parse type tags
> > from BTF.
> >
> > However, a user would be allowed to construct a BTF without such
> > guarantees. Hence, add a pass to check that in modifier chains, type
> > tags only occur at the head of the chain, and then don't occur later in
> > the chain.
> >
> > If we see a type tag, we can have one or more type tags preceding other
> > modifiers that then never have another type tag. If we see other
> > modifiers, all modifiers following them should never be a type tag.
> >
> > Instead of having to walk chains we verified previously, we can remember
> > the last good modifier type ID which headed a good chain. At that point,
> > we must have verified all other chains headed by type IDs less than it.
> > This makes the verification process less costly, and it becomes a simple
> > O(n) pass.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >   kernel/bpf/btf.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 51 insertions(+)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 0918a39279f6..4a73f5b8127e 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -4541,6 +4541,45 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
> >   	return 0;
> >   }
> > +static int btf_check_type_tags(struct btf_verifier_env *env,
> > +			       struct btf *btf, int start_id)
> > +{
> > +	int i, n, good_id = start_id - 1;
> > +	bool in_tags;
> > +
> > +	n = btf_nr_types(btf);
> > +	for (i = start_id; i < n; i++) {
> > +		const struct btf_type *t;
> > +
> > +		t = btf_type_by_id(btf, i);
> > +		if (!t)
> > +			return -EINVAL;
> > +		if (!btf_type_is_modifier(t))
> > +			continue;
> > +
> > +		cond_resched();
> > +
> > +		in_tags = btf_type_is_type_tag(t);
> > +		while (btf_type_is_modifier(t)) {
> > +			if (btf_type_is_type_tag(t)) {
> > +				if (!in_tags) {
> > +					btf_verifier_log(env, "Type tags don't precede modifiers");
> > +					return -EINVAL;
> > +				}
> > +			} else if (in_tags) {
> > +				in_tags = false;
> > +			}
> > +			if (t->type <= good_id)
> > +				break;
>
> General approach looks good. Currently verifier does assume type_tag
> immediately following ptr type and before all other modifiers we do
> need to ensure
>
> I think we may have an issue here though. Suppose we have the
> following types
>    1 ptr -> 2
>    2 tag -> 3
>    3 const -> 4
>    4 int
>    5 ptr -> 6
>    6 const -> 2
>
> In this particular case, when processing modifier 6, we
> have in_tags is false, but t->type (2) <= good_id (5).
> But this is illegal as we have ptr-> const -> tag -> const -> int.
>

Thanks a lot for catching the bug.

So when we have set a non-zero good_id, we know two things:
If good_id is a type tag, it will be followed by one or more type tag modifiers
and then only non type tag modifiers, else it will only be a series of non type
tag modifiers.

When comparing next type ID (t->type) with good_id, we need to see if it is a
type_tag and compare against in_tags to ensure it can be part of current chain.
So this t->type check needs to be changed to be against current type ID, and
should happen in next loop iteration after in_tags has been checked against 't'.

The following change should fix this:

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4a73f5b8127e..c015ccd1c741 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4550,6 +4550,7 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
        n = btf_nr_types(btf);
        for (i = start_id; i < n; i++) {
                const struct btf_type *t;
+               u32 cur_id = i;

                t = btf_type_by_id(btf, i);
                if (!t)
@@ -4569,8 +4570,10 @@ static int btf_check_type_tags(struct btf_verifier_env *env,
                        } else if (in_tags) {
                                in_tags = false;
                        }
-                       if (t->type <= good_id)
+                       if (cur_id <= good_id)
                                break;
+                       /* Move to next type */
+                       cur_id = t->type;
                        t = btf_type_by_id(btf, t->type);
                        if (!t)
                                return -EINVAL;

--

If it looks good, I can respin with your example added as another test in
selftests.

> > +			t = btf_type_by_id(btf, t->type);
> > +			if (!t)
> > +				return -EINVAL;
> > +		}
> > +		good_id = i;
> > +	}
> > +	return 0;
> > +}
> > +
> >   static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
> [...]

--
Kartikeya
