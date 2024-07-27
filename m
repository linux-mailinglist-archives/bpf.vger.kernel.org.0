Return-Path: <bpf+bounces-35781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D70F293DC6F
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 02:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B67B1F23B17
	for <lists+bpf@lfdr.de>; Sat, 27 Jul 2024 00:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030D04688;
	Sat, 27 Jul 2024 00:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzBOsizL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0BD382;
	Sat, 27 Jul 2024 00:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722039141; cv=none; b=GYXvUEc5whjvYKiHCTSl4VZoHmcJGyUVKk7L1vyeOb2IfwAim/Z3OldAwm+ti9caMfkmOGbvCX75hMc5BJLsVq6m11UDpioWryp04TG9EpEaV7LnLEib/O+QSLYwqQlCsBBlR8IWkGR+WxvgwABZtFLmO/ze0omVl7/UePu2B1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722039141; c=relaxed/simple;
	bh=OuG87QLLc84EZhfW8QoRM3tscbQurEP8YtBlKvENVfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WbpiDG5YaqkXBHAcFidpExeXlmSywO1DonkfAQw72QuORbDt+jiOedIM3BiWD2t5c3j67cQcGKpwe4w7GZ72+QnRhRaKxjt2xW5M20Sr8PgE6fv7YB+HlopLTDTlXhBs6myQmg9D9lwDxLQR0wsw93lIbIuaUjPnISvN3rzv7xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzBOsizL; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb56c2c30eso1000019a91.1;
        Fri, 26 Jul 2024 17:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722039139; x=1722643939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GkRR8/Y8aNhAscii0XIMiiUAfuT52ERhwrdOukVozqU=;
        b=hzBOsizLK0nmRKg2mX7Lwm463WiXlNTIpi+BwDnicXPsnEzQNRhWnLUM7jCdJCj63f
         8ZJiTVAUyZDHqKr1T8a8SY8tnWBH/0Z+SzazQAI91RTdvaNaTGR7qiAGk+5Z3eY85Wzw
         QWMu/WtzTHL5O/VUdhOAYg8hkYG+IJlk0LiH0NAYP9dbxBDmEeYYPZK0UnyFQr4VPr4s
         2S1KFezgoqoo2zZk0pce6rFckzsHDzie48K9bh/+nXYeTtAVcbD20YnT9LoYT+FWPdfK
         XjEnJTRVhyRI1f/FyXK2kYcvBtNJDf6ewnzuLePXM0JeLOnoNS5iveBXKD7s7UAgRD+G
         m+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722039139; x=1722643939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GkRR8/Y8aNhAscii0XIMiiUAfuT52ERhwrdOukVozqU=;
        b=J7/Cn6rBM9XiP4CMZOGVQ9YjgYcu7zeVIpkedim5ws/hDtGIbnLgVTIcEVMKCsB5pk
         4PGQiN3k5du+5nVRXnl1zmu9iSr2HfvaIf70VeTGkZVmEHAEWlTxqGUuUuEqpKoHm+DJ
         2qSq8+KW3RcqA2+8hqDCsBo8AtZc9ZIwHxNuD1/RrAm5JUz2Qesc3EDIFgQ8vz8DNjcY
         ZrUZXCXe0fbHFxSeQNnjm/4oCrYnG3Vs+rOmgvTLoDKF3pKeHpWK0+2mdPL295NWj6EK
         r8b28NK9HRpvRwMXeFGeJiNBYkpedmxZw7owc4HKIwgTUmowFey8sbgZ3Prrw6j7Ucrz
         NY3A==
X-Forwarded-Encrypted: i=1; AJvYcCX4VIavJ+hDO3QIJaxSmRj/Xkuh+5QZeHOp2VdzBGMlRGJfvfCicd3me9wf/lhn6hY/DqJ/SSmo7bKfHVwqssNbhiD3nJuz4GkgKeT3tAIEGDOWCDWsdKKqXX9J/fMRGrp6
X-Gm-Message-State: AOJu0YxFJ8TVtcZ41qQXdSk3fn837eEpr8FXFcqZeUfVW63XAqVWXbkq
	PUJ1VGQ0CtOHiBdS3erxmNX66TKh435hh5DQh8HZ9G9fy1UNiAuQejhXy3aW775cGkJCeVOqOIv
	zUpVqNhnry9Ae8x+fRWscKlVsaAM=
X-Google-Smtp-Source: AGHT+IGG8ZJ4ft/l6DBdS1K3UEsw4kL4U9Il2t0F2QwMGzM7nZJTmrrtEdS7OyIp72KOXDqfxWJEJkxJewL2xuJOXkg=
X-Received: by 2002:a17:90a:4b0a:b0:2cd:40cf:5ebd with SMTP id
 98e67ed59e1d1-2cf7ce87444mr1958964a91.5.1722039139080; Fri, 26 Jul 2024
 17:12:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725051511.57112-1-me@manjusaka.me> <08e180da-e841-427d-bed6-3ba8d73e8519@linux.dev>
 <c7952df9-5830-45d3-89bb-b45f2b030e24@gmail.com> <6511ce2a-1c7d-497c-aeb6-d4f0b17271ed@linux.dev>
 <2c6b1737-0a96-44ed-afe9-655444121984@gmail.com> <CAEf4BzbL0xfdCEYmzfQ4qCWQxKJAK=TwsdS3k=L58AoVyObL3Q@mail.gmail.com>
 <0f5b7717-fad3-4c89-bacf-7a11baf7a9df@gmail.com>
In-Reply-To: <0f5b7717-fad3-4c89-bacf-7a11baf7a9df@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jul 2024 17:12:06 -0700
Message-ID: <CAEf4BzZCz+sLuAUF65SaHqPUemsUb0WBhAhLYoaAs54VfH1V2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Add bpf_check_attach_target_with_klog
 method to output failure logs to kernel
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Zheao Li <me@manjusaka.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 7:57=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> On 26/7/24 05:27, Andrii Nakryiko wrote:
> > On Thu, Jul 25, 2024 at 12:33=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.co=
m> wrote:
> >>
> >>
> >>
> >> On 25/7/24 14:09, Yonghong Song wrote:
> >>>
> >>> On 7/24/24 11:05 PM, Leon Hwang wrote:
> >>>>
> >>>> On 25/7/24 13:54, Yonghong Song wrote:
> >>>>> On 7/24/24 10:15 PM, Zheao Li wrote:
> >>>>>> This is a v2 patch, previous Link:
> >>>>>> https://lore.kernel.org/bpf/20240724152521.20546-1-me@manjusaka.me=
/T/#u
> >>>>>>
>
> [SNI]
>

[...]

> >
>
> Build and run, sudo ./retsnoop -e verbose -e bpf_log -e
> bpf_verifier_vlog -e bpf_verifier_log_write -STA -v, here's the output:
>
>
> FUNCTION CALLS   RESULT  DURATION  ARGS
> --------------   ------  --------  ----
> =E2=86=94 bpf_log        [void]   1.350us  log=3DNULL fmt=3D'%s() is not =
a global
> function ' =3D(vararg)
>
> It's great to show arguments.
>

Thanks for repro steps, they worked. Also, I just pushed latest
retsnoop version to Github that does support capturing vararg
arguments for printf-like functions. See full debugging log at [0],
but I basically did just two things:

$ sudo retsnoop -e '*sys_bpf' --lbr -n freplace

-n freplace filters by process name, to avoid the noise. I traced
bpf() syscall (*sys_bf), and I requested function call LBR (Last
Branch Record) stack. LBR showed that we have
bpf_prog_attach_check_attach_type() call, and then eventually we get
to bpf_log().

So I then traced bpf_log (no --lbr this time, but I requested function
trace + arguments capture:

$ sudo retsnoop -n freplace -e '*sys_bpf' -a bpf_log -TA

17:02:39.968302 -> 17:02:39.968307 TID/PID 2730863/2730855 (freplace/frepla=
ce):

FUNCTION CALLS      RESULT     DURATION  ARGS
-----------------   ---------  --------  ----
=E2=86=92 __x64_sys_bpf
regs=3D&{.r15=3D2,.r14=3D0xc0000061c0,.bp=3D0xc00169f8a8,.bx=3D28,.r11=3D51=
4,.ax=3D0xffffffffffffffda,.cx=3D0x404f4e,.dx=3D64,.si=3D0xc00169fa10=E2=80=
=A6
    =E2=86=92 __sys_bpf                          cmd=3D28
uattr=3D{{.kernel=3D0xc00169fa10,.user=3D0xc00169fa10}} size=3D64
        =E2=86=94 bpf_log   [void]      1.550us  log=3DNULL fmt=3D'%s() is =
not a
global function ' vararg0=3D'stub_handler_static'
    =E2=86=90 __sys_bpf     [-EINVAL]   4.115us
=E2=86=90 __x64_sys_bpf     [-EINVAL]   5.467us


For __x64_sys_bpf that's struct pt_regs, which isn't that interesting,
but then we have:

=E2=86=94 bpf_log   [void]      1.550us  log=3DNULL fmt=3D'%s() is not a gl=
obal
function ' vararg0=3D'stub_handler_static'

Which showed format string and the argument passed to it:
'stub_hanler_static' subprogram seems to be the problem here.


Anyways, tbh, for a problem like this, it's probably best to just
request a verbose log when doing the BPF_PROG_LOAD command. You can
*normally* use veristat tool to get that easily, if you have a .bpf.o
object file on the disk. But in this case it's freplace and veristat
doesn't know what's the target BPF program, so it's not that useful in
this case:

$ sudo veristat -v freplace_bpfel.o
Processing 'freplace_bpfel.o'...
libbpf: prog 'freplace_handler': attach program FD is not set
libbpf: prog 'freplace_handler': failed to prepare load attributes: -22
libbpf: prog 'freplace_handler': failed to load: -22
libbpf: failed to load object 'freplace_bpfel.o'
PROCESSING freplace_bpfel.o/freplace_handler, DURATION US: 0, VERDICT:
failure, VERIFIER LOG:

File              Program           Verdict  Duration (us)  Insns
States  Peak states
----------------  ----------------  -------  -------------  -----
------  -----------
freplace_bpfel.o  freplace_handler  failure              0      0
 0            0
----------------  ----------------  -------  -------------  -----
------  -----------
Done. Processed 1 files, 0 programs. Skipped 1 files, 0 programs.

But for lots of other programs this would be a no-brainer.


  [0] https://gist.github.com/anakryiko/88a1597a68e43dc945e40fde88a96e7e

[...]

>
> Is it OK to add a tracepoint here? I think tracepoint is more generic
> than retsnoop-like way.

I personally don't see a problem with adding tracepoint, but how would
it look like, given we are talking about vararg printf-style function
calls? I'm not sure how that should be represented in such a way as to
make it compatible with tracepoints and not cause any runtime
overhead.

>
> Thanks,
> Leon
>
>

