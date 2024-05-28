Return-Path: <bpf+bounces-30805-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069B58D28D6
	for <lists+bpf@lfdr.de>; Wed, 29 May 2024 01:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 297271C226AA
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 23:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D059140363;
	Tue, 28 May 2024 23:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRncSqHn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669F13F45B;
	Tue, 28 May 2024 23:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716939904; cv=none; b=MG6NJcjkmTfrp+OvC0SBg9RaiUmtOxa6WpboUa7PUP7jQE5JiQKm8hYmcyf5FJeS8uhmvl08yVSFR8sKLKMwemiYq/9OUtHVet449pIGv3YMOo3Adkaa2p6kKM5oRl168cm7Hah/6U8uU1A4QCmOBbc8CWnixfgA0X330kxTymg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716939904; c=relaxed/simple;
	bh=La62WtBGp15lXdgSfglnKDWpd6McLGwh0WQLrc6Dimo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=P6ct1mTC9GtjUzsi3kUkUM2zIk3G2y8/GNO1VqpFnTv8dZi2epd3vjz3bf7uPPH8c+a6xeO5gIOH/Qn45rdkmLUK4YByt9bBkZoFrWGTABglyhRlGZzmXTCE7oanN+rK0XyoZWNYUqmxaex35JwhoFARIpTvNPYi4Q9YocL4N70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VRncSqHn; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b3241a69f4so693277eaf.2;
        Tue, 28 May 2024 16:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716939902; x=1717544702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7soaNSolB+9x0tQq566Xu1mPB56BhIJZmxJEGAuijU=;
        b=VRncSqHn15pXGdbUyK8JUpIlVXr/LpNWDlR/27AT57J4lRfVdKLLrvhFFPkax+MylM
         x0thzS0xLehjII1gUoDrL1XpXaqn2t6Uj61CoYZHpe1uY64P3/W2eXhFMbUsFaZ6nVjQ
         bweVAUHUpiQuNEhVtI/0nHClA+11+WQEHJyxsFHuKrC74C6wjLUBngyZqnAl7CK5k01T
         mpnVqqRdXKt3akpCtCzkoAva73BDzPAQoye97x0yxm6UrGNsxu9F/Yjori/cva3hV5Ez
         nLbRr34RYVAktBtUtAJz9tCO3ewnSFakbMUgTFXOsmHM4oZgIoqb2T6X4EQdNNvVlwJL
         fGDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716939902; x=1717544702;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p7soaNSolB+9x0tQq566Xu1mPB56BhIJZmxJEGAuijU=;
        b=k2SWy+GvHC0e5S4oyvSDh/jkXaHtz+MfGbVGBO22iyz/JMrWwJJPiZoz17/cqbLV9a
         /qhthvltQtCj6QZSvXy1ZGmhm/ozTeV2QKOVYNKo77XJaCSF9BWaQnBNERYT1OwkBV5o
         gncWCRVfNIzW1H04cTFBo7TpCusnORSBbcgGrYBtv6s92nj132B+9DEXw8iJHW2Of9b8
         CdGijWMQVH7Bb5uXKkYiP7bK6dUUTDUJ9Fr1j2/WGxn6Jd/uGBOccZhIQh31zaxRfckF
         gWDE5IVaXYyrKiKBo+ErdKhI7ej2t7fGqQzEZkQvPKpzSJTTsDCzpaQbHUZUYEx9V1KE
         XeqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCQCEOoNf8hHvHZvuuI5t6HzsfIh2QuAtGMtOcuIiQMS6kuU75stXEviy77gUO8abUQBGHsoD7qmpmV8a70aaYWPR6HEa+mZo1YVnr4/xSIg5IJ+79iL4q4Akz
X-Gm-Message-State: AOJu0Yx5ScJTrF5pfU6Pr5yz+2DTJzeLameY1cqjS17zDy7IKmcJ3Nun
	HttOT7LxTnpu4VtZgXuIucbkm6IRyc3E6LXxiNsIsEPApQhxNgrX
X-Google-Smtp-Source: AGHT+IFQ2sAMDdtn4HeE138ToSI5VW9XuxxlfqE5MzxxL3VcorBN2C79fpY8+De7glZ2pjNg+bpeyw==
X-Received: by 2002:a05:6358:921d:b0:199:669:488b with SMTP id e5c5f4694b2df-1990669490fmr345404255d.13.1716939901665;
        Tue, 28 May 2024 16:45:01 -0700 (PDT)
Received: from localhost ([98.97.41.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-68221b73d12sm7978801a12.29.2024.05.28.16.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 16:45:01 -0700 (PDT)
Date: Tue, 28 May 2024 16:45:00 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: "Singhai, Anjali" <anjali.singhai@intel.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 "Jain, Vipin" <Vipin.Jain@amd.com>, 
 "Hadi Salim, Jamal" <jhs@mojatatu.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Network Development <netdev@vger.kernel.org>, 
 "Chatterjee, Deb" <deb.chatterjee@intel.com>, 
 "Limaye, Namrata" <namrata.limaye@intel.com>, 
 tom Herbert <tom@sipanda.io>, 
 Marcelo Ricardo Leitner <mleitner@redhat.com>, 
 "Shirshyad, Mahesh" <Mahesh.Shirshyad@amd.com>, 
 "Osinski, Tomasz" <tomasz.osinski@intel.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Cong Wang <xiyou.wangcong@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Vlad Buslov <vladbu@nvidia.com>, 
 Simon Horman <horms@kernel.org>, 
 Khalid Manaa <khalidm@nvidia.com>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Victor Nogueira <victor@mojatatu.com>, 
 "Tammela, Pedro" <pctammela@mojatatu.com>, 
 "Daly, Dan" <dan.daly@intel.com>, 
 Andy Fingerhut <andy.fingerhut@gmail.com>, 
 "Sommers, Chris" <chris.sommers@keysight.com>, 
 Matty Kadosh <mattyk@nvidia.com>, 
 bpf <bpf@vger.kernel.org>, 
 "lwn@lwn.net" <lwn@lwn.net>
Message-ID: <66566c7c6778d_52e720851@john.notmuch>
In-Reply-To: <CO1PR11MB49932999F5467416D4F7197693F12@CO1PR11MB4993.namprd11.prod.outlook.com>
References: <20240410140141.495384-1-jhs@mojatatu.com>
 <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
 <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
 <87cf4830e2e46c1882998162526e108fb424a0f7.camel@redhat.com>
 <CAM0EoMkJwR0K-fF7qo0PfRw4Sf+=2L0L=rOcH5A2ELwagLrZMw@mail.gmail.com>
 <CAM0EoMmfDoZ9_ZdK-ZjHjFAjuNN8fVK+R57_UaFqAm=wA0AWVA@mail.gmail.com>
 <82ee1013ca0164053e9fb1259eaf676343c430e8.camel@redhat.com>
 <CAADnVQLugkg+ahAapskRaE86=RnwpY8v=Nre8pn=sa4fTEoTyA@mail.gmail.com>
 <CAM0EoM=2wHem54vTeVq4H1W5pawYuHNt-aS9JyG8iQORbaw5pA@mail.gmail.com>
 <CAM0EoMmCz5usVSLq_wzR3s7UcaKifa-X58zr6hkPXuSBnwFX3w@mail.gmail.com>
 <CAM0EoMmsB5jHZ=4oJc_Yzm=RFDUHWh9yexdG6_bPFS4_CFuiog@mail.gmail.com>
 <20240522151933.6f422e63@kernel.org>
 <CAM0EoMmFrp5X5OzMbum5i_Bjng7Bhtk1YvWpacW6FV6Oy-3avg@mail.gmail.com>
 <CO1PR11MB499350FC06A5B87E4C770CCE93F42@CO1PR11MB4993.namprd11.prod.outlook.com>
 <MW4PR12MB71927C9E4B94871B45F845DF97F52@MW4PR12MB7192.namprd12.prod.outlook.com>
 <MW4PR12MB719209644426A0F5AE18D2E897F62@MW4PR12MB7192.namprd12.prod.outlook.com>
 <66563bc85f5d0_2f7f2087@john.notmuch>
 <CO1PR11MB49932999F5467416D4F7197693F12@CO1PR11MB4993.namprd11.prod.outlook.com>
Subject: RE: On the NACKs on P4TC patches
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Singhai, Anjali wrote:
> >From: John Fastabend <john.fastabend@gmail.com> 
> >Sent: Tuesday, May 28, 2024 1:17 PM
> 
> >Jain, Vipin wrote:
> >> [AMD Official Use Only - AMD Internal Distribution Only]
> >> 
> >> My apologies, earlier email used html and was blocked by the list...
> >> My response at the bottom as "VJ>"
> >>
> >> ________________________________________
> 
> >Anjali and Vipin is your support for HW support of P4 or a Linux SW implementation of P4. If its for HW support what drivers would we want to support? Can you describe how to program >these devices?
> 
> >At the moment there hasn't been any movement on Linux hardware P4 support side as far as I can tell. Yes there are some SDKs and build kits floating around for FPGAs. For example >maybe start with what drivers in kernel tree run the DPUs that have this support? I think this would be a productive direction to go if we in fact have hardware support in the works.
> 
> >If you want a SW implementation in Linux my opinion is still pushing a DSL into the kernel datapath via qdisc/tc is the wrong direction. Mapping P4 onto hardware blocks is fundamentally >different architecture from mapping
> >P4 onto general purpose CPU and registers. My opinion -- to handle this you need a per architecture backend/JIT to compile the P4 to native instructions.
> >This will give you the most flexibility to define new constructs, best performance, and lowest overhead runtime. We have a P4 BPF backend already and JITs for most architectures I don't >see the need for P4TC in this context.
> 
> >If the end goal is a hardware offload control plane I'm skeptical we even need something specific just for SW datapath. I would propose a devlink or new infra to program the device directly >vs overhead and complexity of abstracting through 'tc'. If you want to emulate your device use BPF or user space datapath.
> 
> >.John
> 
> 
> John,                                                                            
> Let me start by saying production hardware exists i think Jamal posted some links but i can point you to our hardware.

Maybe more direct what Linux drivers support this? That would be
a good first place to start IMO. Similarly what AMD hardware
driver supports this. If I have two drivers from two vendors
with P4 support this is great.

For Intel I assume this is idpf?

To be concrete can we start with Linux driver A and P4 program
P. Modprobe driver A and push P4 program P so that it does
something very simple, and drop a CIDR/Port range into a table.
Perhaps this is so obvious in your community the trouble is in
the context of a Linux driver its not immediately obvious to me
and I would suspect its not obvious to many others.

I really think walking through the key steps here would
really help?

 1. $ p4IntelCompiler p4-dos.p4 -o myp4
 2. $ modprobe idpf
 3. $ ping -i eth0 10.0.0.1 // good
 4. $ p4Load p4-dos.p4
 5. -- load cidr into the hardware somehow -- p4rt-ctrl?
 6. $ ping -i eth0 10.0.0.1 // dropped

This is an honest attempt to help fwiw. Questions would be.

For compilation do we need an artifact from Intel it seems
so from docs. But maybe a typo not sure. I'm not overly stuck
on it but worth mentioning if folks try to follow your docs.

For 2 I assume this is just normal every day module load nothing
to see. Does it pop something up in /proc or in firmware or...?
How do I know its P4 ready?

For 4. How does this actually work? Is it a file in a directory
the driver pushes into firmware? How does the firmware know
I've done this? Does the Linux driver already support this?

For 5 (most interesting) how does this work today. How are
you currently talking to the driver/firmware to insert rules
and discover the tables? And does the idpf driver do this
already? Some side channel I guess? This is p4rt-ctrl?

I've seen docs for above in ipdk, but they are a bit hard
to follow if I'm honest.

I assume IPDK is the source folks talk to when we mention there
is hardware somewhere. Also it seems there is an IPDK BPF support
as well which is interesting.

And do you know how the DPDK implementation works? Can we
learn from them is it just on top of Flow API which we
could easily use in devlink or some other *link I suspect.

> The hardware devices under discussion are capable of being abstracted using the P4 match-action paradigm so that's why we chose TC.
> These devices are programmed using the TC/netlink interface i.e the standard TC control-driver ops apply. While it is clear to us that the P4TC abstraction suffices, we are currently discussing details that will cater for all vendors in our biweekly meetings.
> One big requirement is we want to avoid the flower trap - we dont want to be changing kernel/user/driver code every time we add new datapaths.

I think many 1st order and important points have been skipped. How do you
program the device is it a firmware blob, a set of firmware commands,
something that comes to you on device so only vendor sees this? Maybe
I can infer this from some docs and some examples (by the way I ran
through some of your DPU docs and such) but its unclear how these
map onto Linux networking. Jiri started into this earlier and was
cut off because p4tc was not for hardware offload. Now it is apparently.

P4 is a good DSL for this sure and it has a runtime already specified
which is great.

This is not a qdisc/tc its an entire hardware pipeline I don't see
the reason to put it in TC at all.

> We feel P4TC approach is the path to add Linux kernel support.                   

I disagree with your implementation not your goals to support
flexible hardware. 

>                                                                                  
> The s/w path is needed as well for several reasons.                              
> We need the same P4 program to run either in software or hardware or in both using skip_sw/skip_hw. It could be either in split mode or as an exception path as it is done today in flower or u32. Also it is common now in the P4 community that people define their datapath using their program and will write a control application that works for both hardware and software datapaths. They could be using the software datapath for testing as you said but also for the split/exception path. Chris can probably add more comments on the software datapath.

None of above requires P4TC. For different architectures you
build optimal backend compilers. You have a Xilenx backend,
an Intel backend, and a Linux CPU based backend. I see no
reason to constrain the software case to map to a pipeline
model for example. Software running on a CPU has very different
characteristics from something running on a TOR, or FPGA.
Trying to push all these into one backend "model" will result
in suboptimal result for every target. At the end of the
day my .02$, P4 is a DSL it needs a target dependent compiler
in front of it. I want to optimize my software pipeline the
compiler should compress tables as much as possible and
search for a O(1) lookup even if getting that key is somewhat
expensive. Conversely a TCAM changes the game. An FPGA is
going to be flexible and make lots of tradeoffs here of which
I'm not an expert. Also by avoiding loading the DSL into the kernel
you leave room for others to build new/better/worse DSLs as they
please.

The P4 community writes control applicatoins on top of the
runtime spec right? p4rt-ctl being the thing I found. This
should abstract the endpoint away to work with hardware or
software or FPGA or anything else.

.John

