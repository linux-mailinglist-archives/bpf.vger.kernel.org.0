Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F02550CE0
	for <lists+bpf@lfdr.de>; Sun, 19 Jun 2022 22:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbiFSUJp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Jun 2022 16:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235196AbiFSUJo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Jun 2022 16:09:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE3160D9
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 13:09:43 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id o16so12026966wra.4
        for <bpf@vger.kernel.org>; Sun, 19 Jun 2022 13:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=FE0X95HsQBZTlRurUJFbxQQjEj8/XxMZ+lgqoGCPdfM=;
        b=JJCjBCMgN+Yg63YzmP+3Cnr3a/vNILR7+P/H6UaAQz4AycYKLMaM89dbfn48SqPh0r
         YOuRaTPEFTRLg3ywmLl6TXCeirb4yfp4vi1PXXQlF1tMEUf7vP1XRYhcm+xMO5FFqod2
         h3sY35xg4eexyHl9LpMMfoxBisFeb/MPVLlEsbkiZtzOSmw17hxaYEppJm23FNvThKk+
         dUVTwzZcuoo/tztlSNlfpiA3WMQhU15VH3mnQMy4QhbO6CD0LqgqM+0mhux9WTFjJ8Dq
         8/Lk3Ed2XvPveQ6bNly7koqiLtlRBcq1UiuqSgnR+4tZHsIh6h4x+8QMkVjw1xoBWoaf
         t41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=FE0X95HsQBZTlRurUJFbxQQjEj8/XxMZ+lgqoGCPdfM=;
        b=GSG1rBqI7iC+KkfWkjrmmMYq0QJCtyrmID54+AFbLF80gHJmNQgQuLVuXuhqi/gdx+
         W1qwSru3TUaSpVVEmF+9X1VZXVUxFveSLG4ngrqw/OOWWGgiy/dYKrNVSniBriNLpuD4
         jUzlt8Mb30QMUXMSaUAF05tOWg86sZd67EQDGGRdIk+SBAvZimuGn6OPiq2RNu2NTl8b
         Y/r0JwnmX0M3iIqSxRlW2D6DfVclA2DYjXWYQz41zpKJf/m6rPxXjxkQ9nlhWUVQNm4G
         VZJSmgJlL0YMXdg6oSpuXl6uZ3J2Xb37GqHjhjAULcxf8rNJy8lQzD/hT5F87hNjhZxR
         NYJw==
X-Gm-Message-State: AJIora9dLMmyb9Brz6hxMOB9qTU/F5YuU/FwTsBVroJ2YMnjzmQOnzBs
        svAyn7v5FF+seM65APE6FUY=
X-Google-Smtp-Source: AGRyM1vwdh7tT5V7CBvJ6p6vgVbUKxWzyCczffoJraZJfjM4IqvHFUEp0f55siPJlkaxZFqHU9n6Dw==
X-Received: by 2002:adf:ef01:0:b0:20a:8068:ca5e with SMTP id e1-20020adfef01000000b0020a8068ca5emr19564997wro.661.1655669381541;
        Sun, 19 Jun 2022 13:09:41 -0700 (PDT)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id o4-20020adfcf04000000b0020ff877cfbdsm8406660wrj.87.2022.06.19.13.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 13:09:39 -0700 (PDT)
Message-ID: <fb17ffcbdfa6b75813352133c5655f01aefe71ec.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 3/5] bpf: Inline calls to bpf_loop when
 callback is known
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Song Liu <song@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>
Date:   Sun, 19 Jun 2022 23:09:36 +0300
In-Reply-To: <CAADnVQ+rwwCoEPQUg+CS_iXSzqoptrgtW4TpqoM9XkMW9Jj+ag@mail.gmail.com>
References: <20220613205008.212724-1-eddyz87@gmail.com>
         <20220613205008.212724-4-eddyz87@gmail.com>
         <CAADnVQ+rwwCoEPQUg+CS_iXSzqoptrgtW4TpqoM9XkMW9Jj+ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (by Flathub.org) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Daniel, Alexei,=20

> On Fri, 2022-06-17 at 01:12 +0200, Daniel Borkmann wrote:
> On Thu, 2022-06-16 at 19:14 -0700, Alexei Starovoitov wrote:
> On Mon, Jun 13, 2022 at 1:50 PM Eduard Zingerman <eddyz87@gmail.com> wrot=
e:
> > +
> > +static bool loop_flag_is_zero(struct bpf_verifier_env *env)
[...]
>=20
> Great catch here by Daniel.
> It needs mark_chain_precision().

Thanks for the catch regarding precision tracking. Unfortunately I
struggle to create a test case that demonstrates the issue without the
call to `mark_chain_precision`. As far as I understand this test case
should look as follows:


	... do something in such a way that:
	  - there is a branch where
	    BPF_REG_4 is 0, SCALAR_VALUE, !precise
	    and this branch is explored first
	  - there is a branch where
	    BPF_REG_4 is 1, SCALAR_VALUE, !precise

	/* create branching point */
	BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 0, 0),
	/* load callback address to r2 */
	BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, BPF_REG_2, BPF_PSEUDO_FUNC, 0, 5),
	BPF_RAW_INSN(0, 0, 0, 0, 0),
	BPF_ALU64_IMM(BPF_MOV, BPF_REG_3, 0),
	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_loop),
	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 0),
	BPF_EXIT_INSN(),
	/* callback */
	BPF_ALU64_IMM(BPF_MOV, BPF_REG_0, 1),
	BPF_EXIT_INSN(),

The "do something" part would then rely on the state pruning logic to
skip the verification for the second branch. Namely, the following
part of the `regsafe` function should consider registers identical:

/* Returns true if (rold safe implies rcur safe) */
static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rol=
d,
			struct bpf_reg_state *rcur, struct bpf_id_pair *idmap)
{
	...
	switch (base_type(rold->type)) {
	case SCALAR_VALUE:
		...
		if (rcur->type =3D=3D SCALAR_VALUE) {
here ->			if (!rold->precise && !rcur->precise)
				return true;
			...
		} else {
			...
		}
		...=09
	}
	...=09
}

However, I don't understand what instructions could mark the register
as a scalar with particular value, but w/o `precise` mark. I tried
MOV, JEQ, JNE, MUL, sequence of BPF_ALU64_IMM(MOV, ...) - BPF_STX_MEM
- BPF_LDX_MEM to no avail.

The following observations might be relevant:
- `__mark_reg_known` does not change the state of the `precise` mark;
- `__mark_reg_unknown` always sets `precise` to `true` when there are
  multiple sub-programs (due to the following line:
  `reg->precise =3D env->subprog_cnt > 1 || !env->bpf_capable`);
- there are always multiple sub-programs when `bpf_loop` is used.

Could you please suggest what to do with this test?

Best regards,
Eduard Zingerman


