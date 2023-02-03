Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177BD688B53
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 01:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjBCADy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 19:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbjBCADx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 19:03:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340077A91
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 16:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675382579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jyfxrc/7ZPKLF/u6Ruw0WD2VULIfdrJX3Yw+Mo2r3IQ=;
        b=erIFwdSTjQ504glmn+LHJ97CFB7gE5cIJrj42rns6LWHss4RyQyIXsL1j3IIAaw2s9EnDA
        Lpv+GYIwB8DQAEJ7jaNrwevA0piL0xtHAALutpfz7QUkBIziVM4bf+rgP+i67IJTrqTBFt
        /zoKx7Dzfgg4nu0LOUF2zcN1+9/ekfg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-133-eOTJuBo5NcG4Slco7pqUyA-1; Thu, 02 Feb 2023 19:02:58 -0500
X-MC-Unique: eOTJuBo5NcG4Slco7pqUyA-1
Received: by mail-ed1-f70.google.com with SMTP id s11-20020a056402164b00b004a702699dfaso2123969edx.14
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 16:02:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jyfxrc/7ZPKLF/u6Ruw0WD2VULIfdrJX3Yw+Mo2r3IQ=;
        b=KKn9O0nLvBoE6Y0QL4Z0seOyMdCj7yHvFHdjGn+N0EITRLzo6I2P+5DliBtCpfs8XI
         cjy4bBYkEgwMNuBxwNXLM3vcU8LL9ZNy/LbKbBQLvwkgvXbppWY+XVzIwuRfjcZiPtYv
         +dcx2DZF5buUV8QYPiVM/EuTLUTjIEW3wzKL3NINgGwvJ61eFFBOntMObyq+hZJelyo7
         jSuCjXd/C8RTfZ8qgJpoamr18wbO1nyh8IliFSjSynwVsxbIbceUI6eYlMurx08XQ0uY
         lF/EfXkazhHbhnl/cNACk9AfNQEdlJwEAJr+VXGJNym1VdVZTG6jaPz3ucia/mpoumeg
         F0sw==
X-Gm-Message-State: AO0yUKVN6e2JzFsgl5al+0VhPMEsvgKK0rB6G5cjqOirwGrtKoQU4x+I
        r6wdmMCjpUpJhdyCtFq+J73fQSofVFHhuBl8BK0r0YSB3B7gKjWeRWoSJ0pPYVyWXp1yEzJ6DVC
        HYbfyAe5/Prb0
X-Received: by 2002:a17:906:c5b:b0:883:be32:cd33 with SMTP id t27-20020a1709060c5b00b00883be32cd33mr8973429ejf.35.1675382577129;
        Thu, 02 Feb 2023 16:02:57 -0800 (PST)
X-Google-Smtp-Source: AK7set838NtnsCYnhKppwOgz3AzxWNHBsWqmLSxldhZI0SEnURw3TDrqImN+olXPAlZ6WWiP8gmGgg==
X-Received: by 2002:a17:906:c5b:b0:883:be32:cd33 with SMTP id t27-20020a1709060c5b00b00883be32cd33mr8973402ejf.35.1675382576789;
        Thu, 02 Feb 2023 16:02:56 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ox4-20020a170907100400b008874c903ec5sm501498ejb.43.2023.02.02.16.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 16:02:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id EDBED972DBC; Fri,  3 Feb 2023 01:02:54 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/3] bpf: Add KF_DEPRECATED kfunc flag
In-Reply-To: <CAADnVQJeaU=F9uym9RctfODHbeV-TTK8DiQFTFm_R=N+qF6gYA@mail.gmail.com>
References: <20230202163056.658641-1-void@manifault.com>
 <20230202163056.658641-3-void@manifault.com>
 <CAADnVQJjmnEpXWL8-SAPt5zYXnFYeF8-wXXpA9shOhqUXNPw=g@mail.gmail.com>
 <Y9wq1Fy8sgpGB+pe@maniforge>
 <1ea9adb3-851c-0c04-1655-07d9f3b7f3b0@iogearbox.net>
 <CAADnVQJeaU=F9uym9RctfODHbeV-TTK8DiQFTFm_R=N+qF6gYA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 03 Feb 2023 01:02:54 +0100
Message-ID: <87ilgjehu9.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Thu, Feb 2, 2023 at 3:11 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 2/2/23 10:27 PM, David Vernet wrote:
>> > On Thu, Feb 02, 2023 at 01:21:19PM -0800, Alexei Starovoitov wrote:
>> >> On Thu, Feb 2, 2023 at 8:31 AM David Vernet <void@manifault.com> wrote:
>> >>>
>> >>> Now that we have our kfunc lifecycle expectations clearly documented,
>> >>> and that KF_DEPRECATED is documented as an optional method for kfunc
>> >>> developers and maintainers to provide a deprecation story to BPF users,
>> >>> we need to actually implement the flag.
>> >>>
>> >>> This patch adds KF_DEPRECATED, and updates the verifier to issue a
>> >>> verifier log message if a deprecated kfunc is called. Currently, a BPF
>> >>> program either has to fail to verify, or be loaded with log level 2 in
>> >>> order to see the message. We could eventually enhance this to always
>> >>> be logged regardless of log level or verification status, or we could
>> >>> instead emit a warning to dmesg. This seems like the least controversial
>> >>> option for now.
>> >>>
>> >>> A subsequent patch will add a selftest that verifies this behavior.
>> >>>
>> >>> Signed-off-by: David Vernet <void@manifault.com>
>> >>> ---
>> >>>   include/linux/btf.h   | 1 +
>> >>>   kernel/bpf/verifier.c | 8 ++++++++
>> >>>   2 files changed, 9 insertions(+)
>> >>>
>> >>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> >>> index 49e0fe6d8274..a0ea788ee9b0 100644
>> >>> --- a/include/linux/btf.h
>> >>> +++ b/include/linux/btf.h
>> >>> @@ -71,6 +71,7 @@
>> >>>   #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
>> >>>   #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
>> >>>   #define KF_RCU          (1 << 7) /* kfunc only takes rcu pointer arguments */
>> >>> +#define KF_DEPRECATED   (1 << 8) /* kfunc is slated to be removed or deprecated */
>> >>>
>> >>>   /*
>> >>>    * Tag marking a kernel function as a kfunc. This is meant to minimize the
>> >>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> >>> index 4cc0e70ee71e..22adcf24f9e1 100644
>> >>> --- a/kernel/bpf/verifier.c
>> >>> +++ b/kernel/bpf/verifier.c
>> >>> @@ -8511,6 +8511,11 @@ static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
>> >>>          return meta->kfunc_flags & KF_RCU;
>> >>>   }
>> >>>
>> >>> +static bool is_kfunc_deprecated(const struct bpf_kfunc_call_arg_meta *meta)
>> >>> +{
>> >>> +       return meta->kfunc_flags & KF_DEPRECATED;
>> >>> +}
>> >>> +
>> >>>   static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta *meta, int arg)
>> >>>   {
>> >>>          return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
>> >>> @@ -9646,6 +9651,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>> >>>                          mark_btf_func_reg_size(env, regno, t->size);
>> >>>          }
>> >>>
>> >>> +       if (is_kfunc_deprecated(&meta))
>> >>> +               verbose(env, "calling deprecated kfunc %s\n", func_name);
>> >>> +
>> >>
>> >> Since prog will successfully load, no one will notice this message.
>> >>
>> >> I think we can skip patches 2 and 3 for now.
>>
>> +1, the KF_DEPRECATED could probably for the time being just mentioned
>> in doc.
>>
>> > I can leave them out of the v2 version of the patch set, but the reason
>> > I included them here is because I thought it would be odd to document
>> > KF_DEPRECATED without actually upstreaming it. Agreed that it is
>> > essentially 0 signal in its current form. Hopefully it could be expanded
>> > soon to be louder and more noticeable by not relying on the env log,
>> > which is wiped if the verifier passes, but that's separate from whether
>> > KF_DEPRECATED in general is the API that we want to provide kfunc
>> > developers (in which case at least 2 and 3 would add that in a
>> > non-controversial form).
>>
>> This ideally needs some form of prog load flag which would error upon
>> use of kfuncs with deprecation tag, such that tools probing kernel for
>> feature availability can notice.
>
> Interesting idea.
> By default we can reject loading progs that try to use KF_DEPRECATED,
> but still allow it with explicit load flag.

If we reject by default then adding the deprecation flag would break
applications just as much as just removing the kfunc, which would kinda
defeat the purpose of having the flag in the first place, wouldn't it? :)

-Toke

