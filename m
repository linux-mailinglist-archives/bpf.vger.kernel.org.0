Return-Path: <bpf+bounces-3317-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D630373C187
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 22:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F9E1C2128D
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 20:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A204D12B65;
	Fri, 23 Jun 2023 20:54:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59F101E7
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 20:54:16 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AD4E41
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:54:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f8fb0e7709so13226065e9.2
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 13:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687553650; x=1690145650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qblkJCdJtTY+YbYPS+1fbTmV0LVbHLIkG3ECD0+fNRE=;
        b=gOTvo8ytC4mZ8R0mg7CjeNQaNLDIyBMsxO7UTYonX+o2gPftV0zfok3/gXytPQ72kS
         o84l2/YGdRE4aWbIUQ2yqvcGPPmNpP314NhDXEF8q/q5QbBte+dOTINhl0kl0j2rGb89
         VE/uhlWXqUcc313sUzAITsSxsdRxD6VymDhxxBo7WV7m10os/sdlen4HzyDvBNmi1Ytl
         i2Ut1SIhzer4Jle7PzVV7/PnNLPvSpQ02AtYazedwgnHWpErrEX2QF5psJ/16KlsnG/O
         +NZh0V7ejgxFAl2VLg1NO/XdNZUG3dBWXHb+COr7Ln1PxO0pGDKYHNoTTO6QtnZMqNjw
         n4CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687553650; x=1690145650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qblkJCdJtTY+YbYPS+1fbTmV0LVbHLIkG3ECD0+fNRE=;
        b=fwMhkOgxGWmNrS/kHgz/jeYkiRzxrm0HP0rv5aRQyXNhPQJgxNXuYWth48zXslB7ST
         +UY8ovA/aVUsPR36HxYO48vVTkgyGCPX++JGTcobPnqgHIWDtSC4yaEnXARYEdcuuTyO
         CnYtgG5KRqWdAn3+D5lbGeII4xGUuDLArTbxbYvF7knngNn5pPm4LNKZZ8flaW86ujYp
         DHgcrT8RC+iiPURD9hGTJtEj1z2NTowAak2RaaKjgWy757GgbGQIJ0hh/jWtWrh81lH+
         RVHqFhij6Sb0ASP9P8mlgv93w8UfOFW9wyrjEXNA2veGnWl5aeo5EACrwKAloecKcP58
         AXyQ==
X-Gm-Message-State: AC+VfDy4Jgst+kbGiuN9EM+8EucXXGosQz37nVAxgw5QfVdCMoOwqHHL
	iMzcyVZPhtaEdiGShHMZejJ26r1ud3018LQKx9wPh3izPho=
X-Google-Smtp-Source: ACHHUZ7S4YS5F7wFDF+1QXJ23X3GmHCeNSHQYS9ep6weDiA/caf8ZcCS7LKk7msnwyXVpraNRCd8kM/gtsPI0eTbdMQ=
X-Received: by 2002:a7b:c017:0:b0:3f7:aad8:4e05 with SMTP id
 c23-20020a7bc017000000b003f7aad84e05mr17621680wmb.11.1687553650317; Fri, 23
 Jun 2023 13:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGQdkDvYU_e=_NX+6DRkL_-TeH3p+QtsdZwHkmH0w3Fuzw0C4w@mail.gmail.com>
In-Reply-To: <CAGQdkDvYU_e=_NX+6DRkL_-TeH3p+QtsdZwHkmH0w3Fuzw0C4w@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 23 Jun 2023 13:53:58 -0700
Message-ID: <CAEf4BzZWWjhrpGpbkU+qy5+ZoPVDHnhp9grQcFoxf11B9Lq1Ow@mail.gmail.com>
Subject: Re: [QUESTION] Check weird behavior with CO-RE relocations
To: andrea terzolo <andreaterzolo3@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 3:51=E2=80=AFAM andrea terzolo <andreaterzolo3@gmai=
l.com> wrote:
>
> Hi all!
>
> Recently I faced a strange issue with CO-RE relocations and the
> required privileged to run our eBPF probe. In Falco, we try to support
> a vast range of kernel versions and distros, so to support COS systems

what's COS?

> we added this custom patch [0]. More in detail:
>
> if(...)
> {
> }
> else
> {
>     struct task_struct___cos *task_cos =3D (void *)task;
>
>     if(bpf_core_field_exists(task_cos->audit->loginuid))

unrelated to your issue, but I think you are misusing
bpf_core_field_exists() here. You should only have one arrow in the
field expression (i.e., no extra pointer dereferences except). Or
better use the form bpf_core_field_exists(struct task_struct___cos,
audit). As you wrote it, it might be checking only existence of
loginuid inside typeof(task_cos->audit), but it doesn't check that
task_struct has audit field.

>     {
>         BPF_CORE_READ_INTO(loginuid, task_cos, audit, loginuid.val);
>     }
> }
>
> The issue is that now when running on not-COS systems we face this
> error when using only `CAP_BPF` and `CAP_PERFMON` capabilities:
>
> libbpf: failed to iterate BTF objects: -1
> libbpf: prog 't1_execve_x': relo #791: target candidate search failed
> for [1238] struct audit_task_info: -1
> libbpf: prog 't1_execve_x': relo #791: failed to relocate: -1
> libbpf: failed to perform CO-RE relocations: -1
> libbpf: failed to load object 'bpf_probe'
> libbpf: failed to load BPF skeleton 'bpf_probe': -1
>
> If we use CAP_SYS_ADMIN all seems to work fine. The issue seems
> related to the fact that during the relocation libbpf is not able
> to find `audit_task_info` in the running kernel BTF, since we are not
> running on COS system, and for this reason, it searches for it in
> modules BTF, but in order to do that we need CAP_SYS_ADMIN[1].
> Is this the intended behavior?

Not really, though it is unfortunate that we need CAP_SYS_ADMIN just
to find kernel module's BTF. cc Alexei, maybe we can relax some rules
at least for BTFs?

> If we want to support specific kernel structs like `audit_task_info`
> do we need to run with CAP_SYS_ADMIN always enabled?
> Is there a way to disable BTF module search with libbpf?

We should probably just say that if CAP_SYS_ADMIN is not granted, we
can't relocate against kernel module BTFs.

In load_module_btfs(), just add an extra check after
bpf_btf_get_next_id() for -EPERM. Would you like to submit a fix?

>
> Side point:
> Not sure this is the right place to report it but it seems that some
> COS versions ([2]) backported something wrong: they backported the
> `BPF_FUNC_ktime_get_coarse_ns` bpf helper but not the memcg-based
> memory accounting. For this reason, libbpf doesn't bump the
> RLIMIT_MEMLOCK supposing that the system uses a  memcg-based memory
> accounting and so we face the same error reported here [3]

this feature detection gap is a known issue, unfortunately. There is
no nice way to detect the need for memcg-based accounting,
unfortunately. You'll have to bump RLIMI_MEMLOCK yourself, sorry.


>
> [0]: https://github.com/falcosecurity/libs/pull/1062
> [1]: https://github.com/torvalds/linux/blob/692b7dc87ca6d55ab254f8259e6f9=
70171dc9d01/kernel/bpf/syscall.c#L3704
> [2]: https://github.com/falcosecurity/falco/issues/2626
> [3]: https://lore.kernel.org/netdev/20220610112648.29695-1-quentin@isoval=
ent.com/T/
>

