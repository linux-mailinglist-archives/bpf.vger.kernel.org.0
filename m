Return-Path: <bpf+bounces-954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0001F7093ED
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 11:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08B3281BCE
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811326AA0;
	Fri, 19 May 2023 09:45:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1E56108
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 09:45:22 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EE81BEF
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 02:44:53 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-757742c2e5fso275222785a.1
        for <bpf@vger.kernel.org>; Fri, 19 May 2023 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684489492; x=1687081492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emD7EgBYrHRBu3RrOJg8hVUQZh6epP+8yZN6KaWcKPs=;
        b=RgOLcHL+unIghxd2Mg5LGuRyEGFz3A6SqC0PU9OH7ny331rlXsO7thRt28BmkzIm0U
         05H8JSiikVt+vb9bwZHaJciVAgSlK4Qn3LE5fDXBqWh0cHm3DpsKfKG08hv3Aersndox
         cUSAiVTv8hVr2cK4+X+XvuuONAxzK6Zq5nAUXN+H4AXvG6RlBeZSX8z5OU13L/mHWnjs
         5yDFgZW84AetDAw4CW941GLFQhCta09ukB9qN0dhWdgZqU/t4/EVH83QL0WuzE9IvNTs
         BPLuIqrAGNOjVdsKR7uJddvD0S/pJ9qwKnD6uqSDTNaGa7y0TCSwwval3LUVyU29xAM1
         pKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684489492; x=1687081492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emD7EgBYrHRBu3RrOJg8hVUQZh6epP+8yZN6KaWcKPs=;
        b=i9i8rRFijyXeI4TPh0cDyEAyFozgMZwbyFz1YywtN+gb8ti9Ijc/+HwFmpXFamsO8k
         yxTghLh/K0E+rnkjbgrGpRxljZEN/TIFRtP+gSoAruNvCpJ9SDE/SvqcD62Vq0iKBnoK
         KAIZluIWJJ02iOcQNpQAZUB8hDsw05YSXiBmgGlfZ7O7TqfHjIsQkbdLML60A2h8Mp7s
         Uom8KjYTizO+6478ksPTCrT9LLhxl811boUkcGUDoCtphQvwlAkRmhhrLnDVIk8N8LMC
         Qhgru9OomJXVFE+xX0KwyCYv2cLOmhEOQxVfbbisOOL6OcVCA3NP1EqFQfWd/TXZm70B
         McxQ==
X-Gm-Message-State: AC+VfDx8J7VChSf7kifUFuhSyu5vQfgE1Maf+qRblTw82Ne0QTx9IraY
	ZpSk+sbgBR+y35lUa7TAPu/MPwDqRuXsXNIKjfM=
X-Google-Smtp-Source: ACHHUZ4ukc+IWvCYYBA7NXpkAUnojdPdRJqCo+wsb3WV4TCJrmchnpUKRsr85VqvPS8hOFMlSZpuxDEuVRrQdqc3zxc=
X-Received: by 2002:a05:6214:5003:b0:61b:7e5a:ec00 with SMTP id
 jo3-20020a056214500300b0061b7e5aec00mr3341894qvb.37.1684489491965; Fri, 19
 May 2023 02:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230517161648.17582-1-alan.maguire@oracle.com>
In-Reply-To: <20230517161648.17582-1-alan.maguire@oracle.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 19 May 2023 17:44:16 +0800
Message-ID: <CALOAHbCXC5Qvn80HxVGAFLiVE17zOCyHg12X=vXJvcZCU6_gKg@mail.gmail.com>
Subject: Re: [RFC dwarves 0/6] Encoding function addresses using DECL_TAGs
To: Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, jolsa@kernel.org, yhs@fb.com, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 18, 2023 at 12:18=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> As a means to continue the discussion in [1], which is
> concerned with finding the best long-term solution to
> having a BPF Type Format (BTF) representation of
> functions that is usable for tracing of edge cases, this
> proof-of-concept series is intended to explore one approach
> to adding information to help make tracing more accurate.
>
> A key problem today is that there is no matching from function
> description to the actual instances of a function.
>
> When that function only has one description, that is
> not an issue, but if we have multiple inconsistent
> static functions in different CUs such as
>
> From kernel/irq/irqdesc.c
>
>     static ssize_t wakeup_show(struct kobject *kobj,
>                                struct kobj_attribute *attr, char *buf)
>
> ...and from drivers/base/power/sysfs.c
>
>     static ssize_t wakeup_show(struct device *dev, struct device_attribut=
e *attr,
>                                char *buf);
>
> ...this becomes a problem.  If I am attaching,
> which do I want?  And even if I know which one
> I want, which instance in kallsyms is which?
>

As you described in the above example,  it is natural to attach a
*function* defined in a specific *file_path*.  So why not encoding the
file path instead ? What's the problem in it?

If we expose the addr and let the user select which address to attach,
it will be a trouble to deploy a bpf program across multiple kernels.
While the file path will have a lower chance to be conflict between
different kernel versions. So I think it would be better if we use the
file path instead and let the kernel find the address automatically.
In the old days, when we wanted to deploy a kprobe kernel module or a
systemtap script across multiple kernels, we had to use if-else in the
code, which was really troublesome as it is not scalable. I don't
think we want to do it the same way in the bpf program.

> This series is a proof-of-concept that supports encoding
> function addresses and associating them with BTF FUNC
> descriptions using BTF declaration tags.
>
> More work would need to be done on the kernel side
> to _use_ this representation, but hopefully having a
> rough approach outlined will help make that more feasible.
>
> [1] https://lore.kernel.org/bpf/ZF61j8WJls25BYTl@krava/
>
> Alan Maguire (6):
>   btf_encoder: record function address and if it is local
>   dwarf_loader: store address in function low_pc if available
>   dwarf_loader: transfer low_pc info from subtroutine to its abstract
>     origin
>   btf_encoder: add "addr=3D0x<addr>" function declaration tag if
>     --btf_gen_func_addr specified
>   btf_encoder: store ELF function representations sorted by name _and_
>     address
>   pahole: document --btf_gen_func_addr
>
>  btf_encoder.c      | 64 +++++++++++++++++++++++++++++++++++-----------
>  btf_encoder.h      |  4 +--
>  dwarf_loader.c     | 16 +++++++++---
>  dwarves.h          |  3 +++
>  man-pages/pahole.1 |  8 ++++++
>  pahole.c           | 12 +++++++--
>  6 files changed, 85 insertions(+), 22 deletions(-)
>
> --
> 2.31.1
>


--=20
Regards
Yafang

