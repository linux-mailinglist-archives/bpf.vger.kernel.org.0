Return-Path: <bpf+bounces-65250-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1545CB1E0F7
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 05:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D018018C0B0D
	for <lists+bpf@lfdr.de>; Fri,  8 Aug 2025 03:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0723B1B0413;
	Fri,  8 Aug 2025 03:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TB6a9mpP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B33FE4;
	Fri,  8 Aug 2025 03:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754623555; cv=none; b=FyTxFmJIFRF3g5+o4jan82vMhrj+h0MdVY+s0RvFoU2XmNf+Mu8wjIMvFjBPwi0Ss5WO8cituRaZiiZJ7Yat7o+UjilyVxG1I0p5L4CJ8UpIzlsLwnaksNV3OST+OK7LEDxnvj8YSkjcAZXa3RZmGRArq38vSUDq8BX6O4MZ67E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754623555; c=relaxed/simple;
	bh=qiO1GnnzIVNP6q6HC44Lg7hUetZFJ8R1Man8g4VayNY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pImi5EIFA9ULB8J6z8Ug6YXmBcGN35UArooGp2Vlfq9no8mj4tQgpLP7/6TuN/BaSpUS1irt/ZqyQKozLBy4dE7sschZ/8vHL6xzyU6fVhUCZA4kP8XzINZs0CZYwzEyw9RjPGhZzpA46cBZZzJdcN/KOBDl/Wl0tbN5Om3MYDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TB6a9mpP; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61564c06e0dso2672609a12.3;
        Thu, 07 Aug 2025 20:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754623552; x=1755228352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qiO1GnnzIVNP6q6HC44Lg7hUetZFJ8R1Man8g4VayNY=;
        b=TB6a9mpPM2Jom1ToZRZ2MXS9Fw+HEQWlQwL69vIUXkzEp4g4dK3JlZjfzBxK5PfKUz
         bfFHhLOAMjf+5US9rCbMhlsG1JUUqNKnwAhXCw7MbZSLi4zhxDVzyirqcflFKkOUdCiR
         ZqvgGtKT+070K6nHVvhaaJHJSK7M+Zphj14Stitnq/+24IW/7DK5tANsYfKPPk6zPVqQ
         jgnQA52jXr3uqQnw6uxhfeMGmx0Z40H2spsjrqtt3Kcs8G+PWUIvi7pWttstUetEOVNS
         QzY9pXZVPfpGib2YJG9zyfLpsFgH6EjBdZ2I5nLtAdinUzu80ow+AarBV+8sUwMrLspe
         ndGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754623552; x=1755228352;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qiO1GnnzIVNP6q6HC44Lg7hUetZFJ8R1Man8g4VayNY=;
        b=wssfXiXec2HEFyTwzn32ST+VTnM+46NytdBNk2hZSM0YDkKLwAxQZxZbqOw/f0gDj+
         SEhdeppugjGdlYyxOCbED8w2CYtz+xh4Kl/2hZN3XXNrrJk6wJMXFa8S4NcBAH08HyeG
         od8k101h5OPmL+eIVe8iWBT6fdySfP7v89jf1wakojzQXJd/Ue5FnD+oDWAT8M/dxxuj
         Q/XOXZPliXVIT/xjHPTPdpcBjjIKS9CwzWn+IamxDG+WfaukABGIBYgYzR8I/sheqDrs
         h2RRYO13PvWml05U1at/gn/5g3O75cxisR25HDxCrOE4HE5W4ZYB9fcdYsDVygEAbs8N
         QSqA==
X-Forwarded-Encrypted: i=1; AJvYcCUjhHcWfsEz6YrUMkz0iW6fXNQMCK4kxAZmz/H5+gzBhdbgtqTzMh7Aot2kG7dlbWnDzXE=@vger.kernel.org, AJvYcCVQebG6DtRpqjmIoNSN2wsrp6QmM13zrnpe7tt9e0xlphP+PxQMXlePwuaoxVwFTHCn/KT8E811Gw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwscgRBd+7dfrbYF6yaxY8GdH6vgf+HvYr2xgutHDJPDXfE2SEM
	T9w9+mOOXs+mRrN9f3IfpPPBJ+J6AbSuCy8E5mARdjawWJhi8/NlGfgmcoADp39NQUDK4A==
X-Gm-Gg: ASbGncuoIhV3CO36XRRcRG2FpRWxnpsCwzwIMy94hKUfWmviUHzM5d9YNilQwMiRTPd
	o2S4gutDR05uremKyitvl1SQk1gezPqTtWYM0fS44kp654WuP4rJzP0DFFwTE8R1/F8bsQ1fgeB
	e9AbSlSTQHJnUpmeI+l7OtSg/gs9X8lU3RbpZFoSd9UmPHMQfrnAxW6IL07IRlsSWTao/f+tA/I
	HlEA1doZDYo02Q2/4kH5HtNQj9v3bYkwn8hvSB3+uYXZGfkXK7zmY1uyMTH/13NN2hM13a+uOxX
	KwBLsYr5Wr+Nvg7ay+ORwWnOVKpOhvHhDREWrJKkSOE2o/33r9CAv4hB9K5aap1QE3FxPYWgAxp
	cw78skwCSdYe+t6ZNgVoejTZpjhElrFgSyDVz
X-Google-Smtp-Source: AGHT+IHCmlOVpo9BFy/Ff+E/S7cwjQTZwwsUT7BuCsyLoPGV+GT0sSb/h7CEit59K43PyRQdYoS9qg==
X-Received: by 2002:a05:6402:4309:b0:617:e303:2e4c with SMTP id 4fb4d7f45d1cf-617e3032ff2mr1010122a12.10.1754623551884;
        Thu, 07 Aug 2025 20:25:51 -0700 (PDT)
Received: from ehlo.thunderbird.net ([94.101.114.216])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe79a0sm12828522a12.39.2025.08.07.20.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 20:25:50 -0700 (PDT)
Date: Fri, 08 Aug 2025 00:25:46 -0300
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko <andrii@kernel.org>,
 bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>,
 Yonghong Song <yonghong.song@linux.dev>, dwarves@vger.kernel.org,
 Nick Alcock <nick.alcock@oracle.com>, Kate Carcia <kcarcia@redhat.com>,
 "Jose E. Marchesi" <jose.marchesi@oracle.com>
Subject: Re: [RFC 0/4] BTF archive with unmodified pahole+toolchain
User-Agent: Thunderbird for Android
In-Reply-To: <CAADnVQLr=-E1isAGDH1+U9h4Dta7hgzi==9SnWpKpCWtHQxa5g@mail.gmail.com>
References: <20250807182538.136498-1-acme@kernel.org> <CAADnVQ+cvvHN9CunLP03yRFKz2YJirmF0j80-fZ0A-8aVVopPg@mail.gmail.com> <CA+JHD92DODDESCfwiiCs_ZQ5bGesK5NC+xe5EvONF5g+-Bg+9Q@mail.gmail.com> <CAADnVQLr=-E1isAGDH1+U9h4Dta7hgzi==9SnWpKpCWtHQxa5g@mail.gmail.com>
Message-ID: <7F061596-C814-42DA-AD6A-F766B21A188A@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 7, 2025 11:52:51 PM GMT-03:00, Alexei Starovoitov <alexei=2Estaro=
voitov@gmail=2Ecom> wrote:
>On Thu, Aug 7, 2025 at 7:36=E2=80=AFPM Arnaldo Carvalho de Melo <arnaldo=
=2Emelo@gmail=2Ecom> wrote:

>> On Thu, Aug 7, 2025, 11:09=E2=80=AFPM Alexei Starovoitov <alexei=2Estar=
ovoitov@gmail=2Ecom> wrote:

>>> On Thu, Aug 7, 2025 at 11:25=E2=80=AFAM Arnaldo Carvalho de Melo <acme=
@kernel=2Eorg> wrote:

>>> > This is complementary to today's series from Alan Maguire, as we can=
 use
>>> > the one liner for the kernel build process to test his series withou=
t
>>> > requiring installing a toolchain that generates BTF for each =2Eo fi=
le
>>> > that will result in vmlinux=2E

>>> > Next steps on my side are to:

>>> > 1=2E change pahole for when it receives --format_path=3Dbtf check if
>>> > btf__is_archive(btf) is true, then just replace the current vmlinux =
=2EBTF
>>> > contents with the raw data in this just loaded BTF, short circuiting
>>> > the whole process=2E

>>> > 2=2E the kernel build process should be changed to allow one to ask =
for
>>> > just BTF, not DWARF, and if so, using the above method, strip the DW=
ARF
>>> > info after using it to generate BTF=2E

>>> > Then when compilers are producing BTF, we switch to that, falling ba=
ck
>>> > to the above method when a compiler is known to generate buggy BTF=
=2E

>>> > And also to use in CIs, to compare the output generated by the vario=
us
>>> > methods in the various components=2E

>>> > 3=2E In 2 we can even use the same scheme we use for parallelizing D=
WARF
>>> > loading when loading all the BTF archive members concatenated in vml=
inux
>>> > to dedup them=2E

>>> Before you jump into 1,2,3 let's discuss the end goal=2E
>>> I think the assumption here is that this btf-for-each-=2Eo approach
>>> is supposed to speed up the build, right ?
>>>
>>> pahole step on vmlinux is noticeable, but it's still a fraction
>>> of three vmlinux linking steps=2E

>> I'll need to try thunderbird on the smartphone to send from the smartph=
one, having said that:

Done, easier than expected, let's see if this gets thru vger=2E=2E=2E

>> I never looked at why we have those three linking steps, will try to ed=
ucate myself about that=2E

>>> How much are we realistically thinking to shave off of that pahole ded=
up time?

>> Difficult to say, but given this comment I made:

>> "Also an observation: for distros the optimal way to produce BTF _and_ =
DWARF seems to be the one we have now, don't bother generating =2EBTF for a=
ll =2Eo, just generate DWARF and at the end generate BTF from it 8-)"

>> I fear that most approaches to generate BTF for vmlinux by generating B=
TF by the compiler or pahole for every =2Eo will only make the total vmlinu=
x generation for the common case (distros) slower, not faster=2E

>Yes=2E My gut feel is the same=2E

:-)

>> Be it the compiler or pahole from DWARF, generating BTF _in addition to=
 DWARF_ for each =2Eo will double the space for the things being represente=
d, as the major benefit from BTF is dedup, not per =2Eo (it's more compact,=
 but not by orders of magnitude as with dedup for the whole vmlinux)=2E

>> Option 3 may end up to be the best, i=2Ee=2E generate BTF directly (com=
piler) or from DWARF (pahole) and immediately add it using btf__add_btf() v=
ia some BTF thread, _stripping_ it right away from the =2Eo, to avoid doubl=
ing the disk space needed (DWARF+BTF per =2Eo), and then, in the end, just =
dedup, having DWARF (if asked, which 99% of distros will do) and BTF, again=
, most distros will want (except things like raspberry pi distros, sigh)=2E

>> The same technique, BTW, could be used to reduce the build disk space n=
eeded for DWARF, if we can live with completely stripped =2Eo files (no BTF=
, no DWARF) having it only (dedup'ed: BTF, or not: DWARF) after we harvest =
it for use in the final vmlinux=2E

>I see where you're going, but disk space is cheap and modern
>build systems have fast drives=2E Spinning rust is a thing of the past=2E
>The total size of intermediate objects doesn't matter much=2E
>Stripping dwarf won't reduce =2Eo by sizable amount, so I/O throughput
>won't budge=2E

This is something I think is worth measuring, to clear this doubt with num=
bers, I'll try to do it, I was already planning to=2E

>> But the changes in my series are so small that I think they merit consi=
deration even so=2E

>Agree with that as well, but I'm just not easy about "BTF archives" :)
>The name is too ambitious=2E Concatenated BTF sections is fine,
>but let's not make a big deal out of it=2E

Well, other proposals being discussed would add more metadata to traverse =
these archives, I was just tagging along on the jargon being created :-)

It was just convenient that an unmodified linker was concatenating everyth=
ing and that from the existing BTF headers I could use a preexisting libbpf=
 API, btf__add_btf() merge everything to then use another preexisting API, =
btf__dedup() to get to the same end result=2E=20

I don't see, so far, any other use for a "BTF archive", only as a happy in=
termediate step from a one line change to the kernel to get the linker to h=
ave the BTF "Compile Units" put together in the same order as the DWARF one=
s for the final merge+dedup=2E

- Arnaldo

