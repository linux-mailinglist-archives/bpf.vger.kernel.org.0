Return-Path: <bpf+bounces-37281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AB895389E
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 18:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8920CB226CD
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 16:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BD41BB685;
	Thu, 15 Aug 2024 16:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amUdxyih"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B70C147;
	Thu, 15 Aug 2024 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723740844; cv=none; b=Mztjgugd2n7SUwnbNmigIahU3EHM0BqzB1HsPd1q218grF7Q4dvMGW8eMH9ujeBkFTXvYkryvgkQFWp+6mT7NCkuFLp/WpoUS+/TaJap5X9g0/jCN9U0bMf9M4SSdwhjtzVk5sTUrsncrLI76gPoaNlha0XJ5W1njFXfuQ7SWK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723740844; c=relaxed/simple;
	bh=MkTsuD8dQa1FEi0LOFldhswviCFsD3p/EWT58612d48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0ZLFps8rEC7mVPr/iciU+iBS0x8ZtexmvAfWbdCaFm96PKuBDdTrttgJxoLjy3yXN31OjU23G0NF20XrzlJtEACC5sUuZX7XThx/HskBE9FeNmcHvNOirxHfWTSBaJ9C2tV2v9lRzo6Tg9HxpuDUhvD1JfRaDnLH8ycIaF0p34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amUdxyih; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7a264a24ea7so917043a12.3;
        Thu, 15 Aug 2024 09:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723740843; x=1724345643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sr5V6tC/D5TEZxYcBtnypnpEXYF5gDapbs7CrqpJbmw=;
        b=amUdxyihH47muT/WLs5Q5+FTrUNEWlt2NJRkKyLJmRnGJiK/sDJM9M+SI+wjc1LTsE
         ZucqUF3JKWdXIMGNeAdWzdXW52hr7Sz5l64ndRS0HqD2okGRFZa5E769qvtCApEiaVJR
         Jp9oZnG2DDtAD9y6iD2JxgLJLz9BJjwHyULVamxOADMvdsS/QgzdQER9bqwdLifUV33q
         G3tf+7kiKkWq5jIFc0IbvqQ1yjvF7h9Slm5aJaccEZ8C0sPJTj0yWIt65UDgiubEnhlR
         FFL+kb3mGEkRiVgy8y2Y3udTix4eccbUJ1FgovawFljG+XwQd6Akg8xM78USBW2vzG1W
         Zw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723740843; x=1724345643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sr5V6tC/D5TEZxYcBtnypnpEXYF5gDapbs7CrqpJbmw=;
        b=w1eXg02YiYCClI6P62BV8nUiDUOkCo0QZOTiLs36qgxYF5I9dJ5HChMuYT6QKbZ976
         Kyl0bXzU18Pz1jkEotsVF31xDIwYYs0F5o7GX1MtH8Bx2eEDSbaMpUWr9zehqkeEigmy
         NvYrOgsHjIzY6AdqHiETRKSIAzmUI0dQawSV29MtadPR7h6eTqtfC67b5AMg3apaUIcK
         J4/zD0hDxvyb9SPo2nMtNshcAoms309eGTyS1v/Or9kv10sBOBBNQybWd0qoZUStIKNd
         LlP2M0NAJR30moI1Ae43fNqU/9cdDpvJ0S852yxWudZH/LIH5mcVep3Jjroc4bF5UELg
         DQ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXjudlxW1WP5ynEB6c8+DZUBcJZF/napJqj1APcMFwliTL62W4U1NeriU+LXui9Q7Jr0Xmi+lvXzh+CXKWTqgbZ9rEjBcdXCWBxeQXG37rwRN9SjS4WZMNCpNe3MytZSFFhXT/8SUm1Gcv+9ChKsdFONS88T6LLDxi5uakBVctAtUF5ty4qDtU2BYh3ltOVx6A6Fw89rxgVZk/Q97XaWb/KdKt7jL0gtg==
X-Gm-Message-State: AOJu0YwfafIDG6J1YJY5LkwIROPL8CSY5VLT0KyYfOPJM1lTXPsh1atR
	EhywZa4GBgr7ThbMv89X7j9FUomD9l784++mTZr/zr+tvscJEhb4tp+KYBrygtYaZVRQXFsg2dj
	iCBMaVd0snZfJNayVSzJ+TzO/DHw=
X-Google-Smtp-Source: AGHT+IH7hX38B0Rm4bmGv6mkPGBs7jfMs2K8hVMinMGsP9+u/mgBv571UptAihL07okdLOZy3YVBP3xHHwE64E+hjuU=
X-Received: by 2002:a17:90b:3506:b0:2d3:c65c:eb91 with SMTP id
 98e67ed59e1d1-2d3dffdb965mr262742a91.32.1723740842502; Thu, 15 Aug 2024
 09:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727094405.1362496-1-liaochang1@huawei.com>
 <7eefae59-8cd1-14a5-ef62-fc0e62b26831@huawei.com> <CAEf4BzaO4eG6hr2hzXYpn+7Uer4chS0R99zLn02ezZ5YruVuQw@mail.gmail.com>
 <85991ce3-674d-b46e-b4f9-88a50f7f5122@huawei.com> <CAEf4BzYvpgfFGckcKdzkC_g1J1SFi7xBe=_cjdVy4KEMikvGMw@mail.gmail.com>
 <2c23e9cc-5593-84d0-9157-1e946df941d9@huawei.com> <CAEf4BzZkXWcE7=2FNm-DrSFOR-Pd9LqrQJvV0ShXfPnXzSzYjg@mail.gmail.com>
 <9044640f-727a-f4ec-cb70-35eeeb28111e@huawei.com>
In-Reply-To: <9044640f-727a-f4ec-cb70-35eeeb28111e@huawei.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 09:53:50 -0700
Message-ID: <CAEf4BzaQi8mUW+1DJZvO+D5SXHTj5q7J6WmnP8FvLWXuiFHPvQ@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Optimize the allocation of insn_slot for performance
To: "Liao, Chang" <liaochang1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, 
	"oleg@redhat.com >> Oleg Nesterov" <oleg@redhat.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 7:58=E2=80=AFPM Liao, Chang <liaochang1@huawei.com>=
 wrote:
>
>
>
> =E5=9C=A8 2024/8/15 2:42, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Tue, Aug 13, 2024 at 9:17=E2=80=AFPM Liao, Chang <liaochang1@huawei.=
com> wrote:
> >>
> >>
> >>
> >> =E5=9C=A8 2024/8/13 1:49, Andrii Nakryiko =E5=86=99=E9=81=93:
> >>> On Mon, Aug 12, 2024 at 4:11=E2=80=AFAM Liao, Chang <liaochang1@huawe=
i.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> =E5=9C=A8 2024/8/9 2:26, Andrii Nakryiko =E5=86=99=E9=81=93:
> >>>>> On Thu, Aug 8, 2024 at 1:45=E2=80=AFAM Liao, Chang <liaochang1@huaw=
ei.com> wrote:
> >>>>>>
> >>>>>> Hi Andrii and Oleg.
> >>>>>>
> >>>>>> This patch sent by me two weeks ago also aim to optimize the perfo=
rmance of uprobe
> >>>>>> on arm64. I notice recent discussions on the performance and scala=
bility of uprobes
> >>>>>> within the mailing list. Considering this interest, I've added you=
 and other relevant
> >>>>>> maintainers to the CC list for broader visibility and potential co=
llaboration.
> >>>>>>
> >>>>>
> >>>>> Hi Liao,
> >>>>>
> >>>>> As you can see there is an active work to improve uprobes, that
> >>>>> changes lifetime management of uprobes, removes a bunch of locks ta=
ken
> >>>>> in the uprobe/uretprobe hot path, etc. It would be nice if you can
> >>>>> hold off a bit with your changes until all that lands. And then
> >>>>> re-benchmark, as costs might shift.
> >>>>>
> >>>>> But also see some remarks below.
> >>>>>
> >>>>>> Thanks.
> >>>>>>
> >>>>>> =E5=9C=A8 2024/7/27 17:44, Liao Chang =E5=86=99=E9=81=93:
> >>>>>>> The profiling result of single-thread model of selftests bench re=
veals
> >>>>>>> performance bottlenecks in find_uprobe() and caches_clean_inval_p=
ou() on
> >>>>>>> ARM64. On my local testing machine, 5% of CPU time is consumed by
> >>>>>>> find_uprobe() for trig-uprobe-ret, while caches_clean_inval_pou()=
 take
> >>>>>>> about 34% of CPU time for trig-uprobe-nop and trig-uprobe-push.
> >>>>>>>
> >>>>>>> This patch introduce struct uprobe_breakpoint to track previously
> >>>>>>> allocated insn_slot for frequently hit uprobe. it effectively red=
uce the
> >>>>>>> need for redundant insn_slot writes and subsequent expensive cach=
e
> >>>>>>> flush, especially on architecture like ARM64. This patch has been=
 tested
> >>>>>>> on Kunpeng916 (Hi1616), 4 NUMA nodes, 64 cores@ 2.4GHz. The selft=
est
> >>>>>>> bench and Redis GET/SET benchmark result below reveal obivious
> >>>>>>> performance gain.
> >>>>>>>
> >>>>>>> before-opt
> >>>>>>> ----------
> >>>>>>> trig-uprobe-nop:  0.371 =C2=B1 0.001M/s (0.371M/prod)
> >>>>>>> trig-uprobe-push: 0.370 =C2=B1 0.001M/s (0.370M/prod)
> >>>>>>> trig-uprobe-ret:  1.637 =C2=B1 0.001M/s (1.647M/prod)
> >>>>>
> >>>>> I'm surprised that nop and push variants are much slower than ret
> >>>>> variant. This is exactly opposite on x86-64. Do you have an
> >>>>> explanation why this might be happening? I see you are trying to
> >>>>> optimize xol_get_insn_slot(), but that is (at least for x86) a slow
> >>>>> variant of uprobe that normally shouldn't be used. Typically uprobe=
 is
> >>>>> installed on nop (for USDT) and on function entry (which would be p=
ush
> >>>>> variant, `push %rbp` instruction).
> >>>>>
> >>>>> ret variant, for x86-64, causes one extra step to go back to user
> >>>>> space to execute original instruction out-of-line, and then trappin=
g
> >>>>> back to kernel for running uprobe. Which is what you normally want =
to
> >>>>> avoid.
> >>>>>
> >>>>> What I'm getting at here. It seems like maybe arm arch is missing f=
ast
> >>>>> emulated implementations for nops/push or whatever equivalents for
> >>>>> ARM64 that is. Please take a look at that and see why those are slo=
w
> >>>>> and whether you can make those into fast uprobe cases?
> >>>>
> >>>> Hi Andrii,
> >>>>
> >>>> As you correctly pointed out, the benchmark result on Arm64 is count=
erintuitive
> >>>> compared to X86 behavior. My investigation revealed that the root ca=
use lies in
> >>>> the arch_uprobe_analyse_insn(), which excludes the Arm64 equvialents=
 instructions
> >>>> of 'nop' and 'push' from the emulatable instruction list. This force=
s the kernel
> >>>> to handle these instructions out-of-line in userspace upon breakpoin=
t exception
> >>>> is handled, leading to a significant performance overhead compared t=
o 'ret' variant,
> >>>> which is already emulated.
> >>>>
> >>>> To address this issue, I've developed a patch supports  the emulatio=
n of 'nop' and
> >>>> 'push' variants. The benchmark results below indicates the performan=
ce gain of
> >>>> emulation is obivious.
> >>>>
> >>>> xol (1 cpus)
> >>>> ------------
> >>>> uprobe-nop:  0.916 =C2=B1 0.001M/s (0.916M/prod)
> >>>> uprobe-push: 0.908 =C2=B1 0.001M/s (0.908M/prod)
> >>>> uprobe-ret:  1.855 =C2=B1 0.000M/s (1.855M/prod)
> >>>> uretprobe-nop:  0.640 =C2=B1 0.000M/s (0.640M/prod)
> >>>> uretprobe-push: 0.633 =C2=B1 0.001M/s (0.633M/prod)
> >>>> uretprobe-ret:  0.978 =C2=B1 0.003M/s (0.978M/prod)
> >>>>
> >>>> emulation (1 cpus)
> >>>> -------------------
> >>>> uprobe-nop:  1.862 =C2=B1 0.002M/s  (1.862M/s/cpu)
> >>>> uprobe-push: 1.743 =C2=B1 0.006M/s  (1.743M/s/cpu)
> >>>> uprobe-ret:  1.840 =C2=B1 0.001M/s  (1.840M/s/cpu)
> >>>> uretprobe-nop:  0.964 =C2=B1 0.004M/s  (0.964M/s/cpu)
> >>>> uretprobe-push: 0.936 =C2=B1 0.004M/s  (0.936M/s/cpu)
> >>>> uretprobe-ret:  0.940 =C2=B1 0.001M/s  (0.940M/s/cpu)
> >>>>
> >>>> As you can see, the performance gap between nop/push and ret variant=
s has been significantly
> >>>> reduced. Due to the emulation of 'push' instruction need to access u=
serspace memory, it spent
> >>>> more cycles than the other.
> >>>
> >>> Great, it's an obvious improvement. Are you going to send patches
> >>> upstream? Please cc bpf@vger.kernel.org as well.
> >>
> >> I'll need more time to thoroughly test this patch. The emulation o pus=
h/nop
> >> instructions also impacts the kprobe/kretprobe paths on Arm64, As as r=
esult,
> >> I'm working on enhancements to trig-kprobe/kretprobe to prevent perfor=
mance
> >> regression.
> >
> > Why would the *benchmarks* have to be modified? The typical
> > kprobe/kretprobe attachment should be fast, and those benchmarks
> > simulate typical fast path kprobe/kretprobe. Is there some simulation
> > logic that is shared between uprobes and kprobes or something?
>
> Yes, kprobe and uprobe share many things for Arm64, but there are curical
> difference. Let me explain further. Simulating a 'push' instruction on
> arm64 will modify the stack pointer at *probe breakpoint. However, kprobe
> and uprobe use different way to restore the stack pointer upon returning
> from the breakpoint exception. Consequently.sharing the same simulation
> logic for both would result in kernel panic for kprobe.
>
> To avoid complicating the exception return logic, I've opted to simuate
> 'push' only for uprobe and maintain the single-stepping for kprobe [0].
> This trade-off avoid the impacts to kprobe/kretprobe, and no need to
> change the kprobe/kretprobe related benchmark.
>

I see, thanks for explaining. I noticed the "bool kernel" flag you
added, it makes sense.

I still don't understand why you'd need to modify kprobe/kretprobe
benchmarks, as they are testing attaching kprobe at the kernel
function entry, which for kernels should be an optimized case not
requiring any emulation.

> [0] https://lore.kernel.org/all/20240814080356.2639544-1-liaochang1@huawe=
i.com/
>
> >
> >>
> >>>
> >>>
> >>> I'm also thinking we should update uprobe/uretprobe benchmarks to be
> >>> less x86-specific. Right now "-nop" is the happy fastest case, "-push=
"
> >>> is still happy, slightly slower case (due to the need to emulate stac=
k
> >>> operation) and "-ret" is meant to be the slow single-step case. We
> >>> should adjust the naming and make sure that on ARM64 we hit similar
> >>> code paths. Given you seem to know arm64 pretty well, can you please
> >>> take a look at updating bench tool for ARM64 (we can also rename
> >>> benchmarks to something a bit more generic, rather than using
> >>> instruction names)?
> >>
> >
> > [...]
>
> --
> BR
> Liao, Chang

