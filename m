Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AB8646738
	for <lists+bpf@lfdr.de>; Thu,  8 Dec 2022 03:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLHCrV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 21:47:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiLHCrU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 21:47:20 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C787254354
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 18:47:18 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id k7so230609pll.6
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 18:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seZagVm7scg9XMuOKfubxdvmjqDtcHZYetAUJI/+96k=;
        b=qnnCQcC73WX5FCg04PkDyKIaiEpI7t+u7i+rOWRWajtxB8KZsBJRxSgC07sdn7Mg8x
         P6tG66MI1C1hyMyM6l+a220bXbOmA4L8W+GhJ1twoM8D0xSBPqAHt14xRrY25U7K4G5T
         NnqLVAdllodYzA8RLxdDRm1fwg/ZIPQb9/qNWQU/b+EpGEvS7723veZmLoVif1wRxa9u
         e21LEiKmxUyBLIXNvUIJ8HGXDTIGTUGxkpiBMMeILDXeCGpXH8rKzoxQ/5QFeCxbai7/
         PoFMGNNU58w+gn7n2X9xp/snarOMIAtsIJMMgH8ewPT+/yojGadTQ35b1Cp2b4aN1zsA
         9Hcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seZagVm7scg9XMuOKfubxdvmjqDtcHZYetAUJI/+96k=;
        b=0qiEHRPbu+1v3NAbOY+2VUFrPuI2K/iBfiFbpykrgJkLNm4H4mALJ2gRCo/3ywRilS
         mmJKG83g57atGyEEsBToPQsHos4KtntYHG9GKnDFlMn+cq+i5RN82Zaade5y635n3zat
         a6yRPnn/1gLJElsOyq47tZjC5QHrz65PiXZN04ja8+TPgNKSJVyxFj48WUKTWQ6iUPF7
         RnuCibeCWMVFNIdv9tuo8p+vCdx2+CZ2rH0khmY+V2PzF6Cy4+bx86yYTgv1H9R9DzmL
         auhXjWhh84QppEvQ2v/zGKwu4bfxSF7U9oanc1G/BbxaxKuIjyQslZMbsf61bIxshoK4
         Iq6g==
X-Gm-Message-State: ANoB5pk+CxfdxgNW//LQzCrZAiUe81In2ekaCexqd4gDQbaK9zGx0boE
        2DflyqhvFO60Hd4rAmveNw==
X-Google-Smtp-Source: AA0mqf6e2Ynz9SDonVuEIrys76CfVAPMs/JvNX7XLpH4gfqWQdKTSOkfy6rLYTi6BL5E1auuq2ZTVw==
X-Received: by 2002:a17:902:ced1:b0:179:ee31:1527 with SMTP id d17-20020a170902ced100b00179ee311527mr46048943plg.138.1670467638128;
        Wed, 07 Dec 2022 18:47:18 -0800 (PST)
Received: from smtpclient.apple ([144.214.0.6])
        by smtp.gmail.com with ESMTPSA id r15-20020a17090a690f00b00219b04cf66asm1775379pjj.36.2022.12.07.18.47.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2022 18:47:17 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.200.110.1.12\))
Subject: Re: [PATCH bpf-next] bpf: Restrict attachment of bpf program to some
 tracepoints
From:   Hao Sun <sunhao.th@gmail.com>
In-Reply-To: <Y5CXm+gL0lvdsd9e@krava>
Date:   Thu, 8 Dec 2022 10:47:04 +0800
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DEB5101-7BCD-46AA-817A-A878CE9469BE@gmail.com>
References: <20221121213123.1373229-1-jolsa@kernel.org>
 <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net> <Y388m6wOktvZo1d4@krava>
 <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
 <Y4CMbTeVud0WfPtK@krava>
 <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
 <Y40U1D2bV+hlS/oi@krava> <Y5CXm+gL0lvdsd9e@krava>
To:     Jiri Olsa <olsajiri@gmail.com>
X-Mailer: Apple Mail (2.3731.200.110.1.12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On 7 Dec 2022, at 9:39 PM, Jiri Olsa <olsajiri@gmail.com> wrote:
>=20
> On Sun, Dec 04, 2022 at 10:44:52PM +0100, Jiri Olsa wrote:
>> On Wed, Nov 30, 2022 at 03:29:39PM -0800, Andrii Nakryiko wrote:
>>> On Fri, Nov 25, 2022 at 1:35 AM Jiri Olsa <olsajiri@gmail.com> =
wrote:
>>>>=20
>>>> On Thu, Nov 24, 2022 at 09:17:22AM -0800, Alexei Starovoitov wrote:
>>>>> On Thu, Nov 24, 2022 at 1:42 AM Jiri Olsa <olsajiri@gmail.com> =
wrote:
>>>>>>=20
>>>>>> On Thu, Nov 24, 2022 at 01:41:23AM +0100, Daniel Borkmann wrote:
>>>>>>> On 11/21/22 10:31 PM, Jiri Olsa wrote:
>>>>>>>> We hit following issues [1] [2] when we attach bpf program that =
calls
>>>>>>>> bpf_trace_printk helper to the contention_begin tracepoint.
>>>>>>>>=20
>>>>>>>> As described in [3] with multiple bpf programs that call =
bpf_trace_printk
>>>>>>>> helper attached to the contention_begin might result in =
exhaustion of
>>>>>>>> printk buffer or cause a deadlock [2].
>>>>>>>>=20
>>>>>>>> There's also another possible deadlock when multiple bpf =
programs attach
>>>>>>>> to bpf_trace_printk tracepoint and call one of the printk bpf =
helpers.
>>>>>>>>=20
>>>>>>>> This change denies the attachment of bpf program to =
contention_begin
>>>>>>>> and bpf_trace_printk tracepoints if the bpf program calls one =
of the
>>>>>>>> printk bpf helpers.
>>>>>>>>=20
>>>>>>>> Adding also verifier check for tb_btf programs, so this can be =
cought
>>>>>>>> in program loading time with error message like:
>>>>>>>>=20
>>>>>>>>   Can't attach program with bpf_trace_printk#6 helper to =
contention_begin tracepoint.
>>>>>>>>=20
>>>>>>>> [1] =
https://lore.kernel.org/bpf/CACkBjsakT_yWxnSWr4r-0TpPvbKm9-OBmVUhJb7hV3hY8=
fdCkw@mail.gmail.com/
>>>>>>>> [2] =
https://lore.kernel.org/bpf/CACkBjsaCsTovQHFfkqJKto6S4Z8d02ud1D7MPESrHa1cV=
NNTrw@mail.gmail.com/
>>>>>>>> [3] https://lore.kernel.org/bpf/Y2j6ivTwFmA0FtvY@krava/
>>>>>>>>=20
>>>>>>>> Reported-by: Hao Sun <sunhao.th@gmail.com>
>>>>>>>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>>>>>>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>>>>>>> ---
>>>>>>>>  include/linux/bpf.h          |  1 +
>>>>>>>>  include/linux/bpf_verifier.h |  2 ++
>>>>>>>>  kernel/bpf/syscall.c         |  3 +++
>>>>>>>>  kernel/bpf/verifier.c        | 46 =
++++++++++++++++++++++++++++++++++++
>>>>>>>>  4 files changed, 52 insertions(+)
>>>>>>>>=20
>>>>>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>>>>>> index c9eafa67f2a2..3ccabede0f50 100644
>>>>>>>> --- a/include/linux/bpf.h
>>>>>>>> +++ b/include/linux/bpf.h
>>>>>>>> @@ -1319,6 +1319,7 @@ struct bpf_prog {
>>>>>>>>                            enforce_expected_attach_type:1, /* =
Enforce expected_attach_type checking at attach time */
>>>>>>>>                            call_get_stack:1, /* Do we call =
bpf_get_stack() or bpf_get_stackid() */
>>>>>>>>                            call_get_func_ip:1, /* Do we call =
get_func_ip() */
>>>>>>>> +                           call_printk:1, /* Do we call =
trace_printk/trace_vprintk  */
>>>>>>>>                            tstamp_type_access:1; /* Accessed =
__sk_buff->tstamp_type */
>>>>>>>>    enum bpf_prog_type      type;           /* Type of BPF =
program */
>>>>>>>>    enum bpf_attach_type    expected_attach_type; /* For some =
prog types */
>>>>>>>> diff --git a/include/linux/bpf_verifier.h =
b/include/linux/bpf_verifier.h
>>>>>>>> index 545152ac136c..7118c2fda59d 100644
>>>>>>>> --- a/include/linux/bpf_verifier.h
>>>>>>>> +++ b/include/linux/bpf_verifier.h
>>>>>>>> @@ -618,6 +618,8 @@ bool is_dynptr_type_expected(struct =
bpf_verifier_env *env,
>>>>>>>>                         struct bpf_reg_state *reg,
>>>>>>>>                         enum bpf_arg_type arg_type);
>>>>>>>> +int bpf_check_tp_printk_denylist(const char *name, struct =
bpf_prog *prog);
>>>>>>>> +
>>>>>>>>  /* this lives here instead of in bpf.h because it needs to =
dereference tgt_prog */
>>>>>>>>  static inline u64 bpf_trampoline_compute_key(const struct =
bpf_prog *tgt_prog,
>>>>>>>>                                         struct btf *btf, u32 =
btf_id)
>>>>>>>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
>>>>>>>> index 35972afb6850..9a69bda7d62b 100644
>>>>>>>> --- a/kernel/bpf/syscall.c
>>>>>>>> +++ b/kernel/bpf/syscall.c
>>>>>>>> @@ -3329,6 +3329,9 @@ static int bpf_raw_tp_link_attach(struct =
bpf_prog *prog,
>>>>>>>>            return -EINVAL;
>>>>>>>>    }
>>>>>>>> +   if (bpf_check_tp_printk_denylist(tp_name, prog))
>>>>>>>> +           return -EACCES;
>>>>>>>> +
>>>>>>>>    btp =3D bpf_get_raw_tracepoint(tp_name);
>>>>>>>>    if (!btp)
>>>>>>>>            return -ENOENT;
>>>>>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>>>>>> index f07bec227fef..b662bc851e1c 100644
>>>>>>>> --- a/kernel/bpf/verifier.c
>>>>>>>> +++ b/kernel/bpf/verifier.c
>>>>>>>> @@ -7472,6 +7472,47 @@ static void =
update_loop_inline_state(struct bpf_verifier_env *env, u32 subprogno
>>>>>>>>                             state->callback_subprogno =3D=3D =
subprogno);
>>>>>>>>  }
>>>>>>>> +int bpf_check_tp_printk_denylist(const char *name, struct =
bpf_prog *prog)
>>>>>>>> +{
>>>>>>>> +   static const char * const denylist[] =3D {
>>>>>>>> +           "contention_begin",
>>>>>>>> +           "bpf_trace_printk",
>>>>>>>> +   };
>>>>>>>> +   int i;
>>>>>>>> +
>>>>>>>> +   /* Do not allow attachment to denylist[] tracepoints,
>>>>>>>> +    * if the program calls some of the printk helpers,
>>>>>>>> +    * because there's possibility of deadlock.
>>>>>>>> +    */
>>>>>>>=20
>>>>>>> What if that prog doesn't but tail calls into another one which =
calls printk helpers?
>>>>>>=20
>>>>>> right, I'll deny that for all BPF_PROG_TYPE_RAW_TRACEPOINT* =
programs,
>>>>>> because I don't see easy way to check on that
>>>>>>=20
>>>>>> we can leave printk check for tracing BPF_TRACE_RAW_TP programs,
>>>>>> because verifier known the exact tracepoint already
>>>>>=20
>>>>> This is all fragile and merely a stop gap.
>>>>> Doesn't sound that the issue is limited to bpf_trace_printk
>>>>=20
>>>> hm, I don't have a better idea how to fix that.. I can't deny
>>>> contention_begin completely, because we use it in perf via
>>>> tp_btf/contention_begin (perf lock contention) and I don't
>>>> think there's another way for perf to do that
>>>>=20
>>>> fwiw the last version below denies BPF_PROG_TYPE_RAW_TRACEPOINT
>>>> programs completely and tracing BPF_TRACE_RAW_TP with printks
>>>>=20
>>>=20
>>> I think disabling bpf_trace_printk() tracepoint for any BPF program =
is
>>> totally fine. This tracepoint was never intended to be attached to.
>>>=20
>>> But as for the general bpf_trace_printk() deadlocking. Should we
>>> discuss how to make it not deadlock instead of starting to denylist
>>> things left and right?
>>>=20
>>> Do I understand that we take trace_printk_lock only to protect that
>>> static char buf[]? Can we just make this buf per-CPU and do a =
trylock
>>> instead? We'll only fail to bpf_trace_printk() something if we have
>>> nested BPF programs (rare) or NMI (also rare).
>>=20
>> ugh, sorry I overlooked your reply :-\
>>=20
>> sounds good.. if it'd be acceptable to use trylock, we'd get rid of =
the
>> contention_begin tracepoint being triggered, which was the case for =
deadlock
>=20
> looks like we can remove the spinlock completely by using the
> nested level buffer approach same way as in bpf_bprintf_prepare
>=20
> it gets rid of the contention_begin tracepoint, so I'm not being
> able to trigger the issue in my test
>=20
> jirka
>=20
>=20
> ---
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 3bbd3f0c810c..d6afde7311f8 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -369,33 +369,60 @@ static const struct bpf_func_proto =
*bpf_get_probe_write_proto(void)
> return &bpf_probe_write_user_proto;
> }
>=20
> -static DEFINE_RAW_SPINLOCK(trace_printk_lock);
> -
> #define MAX_TRACE_PRINTK_VARARGS 3
> #define BPF_TRACE_PRINTK_SIZE 1024
> +#define BPF_TRACE_PRINTK_NEST 3
> +
> +struct trace_printk_buf {
> + char data[BPF_TRACE_PRINTK_NEST][BPF_TRACE_PRINTK_SIZE];
> + int nest;
> +};
> +static DEFINE_PER_CPU(struct trace_printk_buf, printk_buf);
> +
> +static void put_printk_buf(struct trace_printk_buf __percpu *buf)
> +{
> + this_cpu_dec(buf->nest);
> + preempt_enable();
> +}
> +
> +static bool get_printk_buf(struct trace_printk_buf __percpu *buf, =
char **data)
> +{
> + int nest;
> +
> + preempt_disable();
> + nest =3D this_cpu_inc_return(buf->nest);
> + if (nest > BPF_TRACE_PRINTK_NEST) {
> + put_printk_buf(buf);
> + return false;
> + }
> + *data =3D (char *) this_cpu_ptr(&buf->data[nest - 1]);
> + return true;
> +}
>=20
> BPF_CALL_5(bpf_trace_printk, char *, fmt, u32, fmt_size, u64, arg1,
>    u64, arg2, u64, arg3)
> {
> u64 args[MAX_TRACE_PRINTK_VARARGS] =3D { arg1, arg2, arg3 };
> u32 *bin_args;
> - static char buf[BPF_TRACE_PRINTK_SIZE];
> - unsigned long flags;
> + char *buf;
> int ret;
>=20
> + if (!get_printk_buf(&printk_buf, &buf))
> + return -EBUSY;
> +
> ret =3D bpf_bprintf_prepare(fmt, fmt_size, args, &bin_args,
>   MAX_TRACE_PRINTK_VARARGS);
> if (ret < 0)
> - return ret;
> + goto out;
>=20
> - raw_spin_lock_irqsave(&trace_printk_lock, flags);
> - ret =3D bstr_printf(buf, sizeof(buf), fmt, bin_args);
> + ret =3D bstr_printf(buf, BPF_TRACE_PRINTK_SIZE, fmt, bin_args);
>=20
> trace_bpf_trace_printk(buf);
> - raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
>=20
> bpf_bprintf_cleanup();
>=20
> +out:
> + put_printk_buf(&printk_buf);
> return ret;
> }
>=20
> @@ -427,31 +454,35 @@ const struct bpf_func_proto =
*bpf_get_trace_printk_proto(void)
> return &bpf_trace_printk_proto;
> }
>=20
> +static DEFINE_PER_CPU(struct trace_printk_buf, vprintk_buf);
> +
> BPF_CALL_4(bpf_trace_vprintk, char *, fmt, u32, fmt_size, const void =
*, data,
>    u32, data_len)
> {
> - static char buf[BPF_TRACE_PRINTK_SIZE];
> - unsigned long flags;
> int ret, num_args;
> u32 *bin_args;
> + char *buf;
>=20
> if (data_len & 7 || data_len > MAX_BPRINTF_VARARGS * 8 ||
>     (data_len && !data))
> return -EINVAL;
> num_args =3D data_len / 8;
>=20
> + if (!get_printk_buf(&vprintk_buf, &buf))
> + return -EBUSY;
> +
> ret =3D bpf_bprintf_prepare(fmt, fmt_size, data, &bin_args, num_args);
> if (ret < 0)
> - return ret;
> + goto out;
>=20
> - raw_spin_lock_irqsave(&trace_printk_lock, flags);
> - ret =3D bstr_printf(buf, sizeof(buf), fmt, bin_args);
> + ret =3D bstr_printf(buf, BPF_TRACE_PRINTK_SIZE, fmt, bin_args);
>=20
> trace_bpf_trace_printk(buf);
> - raw_spin_unlock_irqrestore(&trace_printk_lock, flags);
>=20
> bpf_bprintf_cleanup();
>=20
> +out:
> + put_printk_buf(&vprintk_buf);
> return ret;
> }

Tested on a latest bpf-next build, I can confirm the patch also fixes
this[1] issue.

[1] =
https://lore.kernel.org/bpf/CACkBjsb3GRw5aiTT=3DRCUs3H5aum_QN+B0ZqZA=3DMvj=
spUP6NFMg@mail.gmail.com/T/#u=
