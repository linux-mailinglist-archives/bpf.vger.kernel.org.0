Return-Path: <bpf+bounces-45191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BAF9D296A
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 16:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6F831F22E13
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD111CF2A6;
	Tue, 19 Nov 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi/gPMnI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736F922067;
	Tue, 19 Nov 2024 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029348; cv=none; b=XdyR/MQYkeKU8DWkxBlI38k/GPHQEt1t1ZSCDqi7d6pFETRfrfJO18T8FcimMtajy2v0o7pvjSiRZ1MymAWnjTakzhAuhldlgu6Wz2Lv1RGR///kIwWzAea9BbaAwJ/V7gqPgiE4ndDnapE+GtJA3O0jGNogobxBn5D2KglD4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029348; c=relaxed/simple;
	bh=iPWDJs3HvioJCWxk5FkWG2QEGmZ5PwQQdJ9AY+MrLrw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0HzpXhElrxbnQ7CvNxGkH9MJBut3s2YsecMeI/VUdlqzhmXBGxqkstCPRBgq61s9Ih29opfP+Gt4s2VOOJzgETrE0fmrWu9TBmElch94+eTeNP5iSU+PVP8C/kOwJgsKSk77K3i1wwL6TRMhbKvU6SRIlO+QFZrFyXD6sWMLHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi/gPMnI; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-38230ed9baeso2721714f8f.1;
        Tue, 19 Nov 2024 07:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732029345; x=1732634145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5UnjguskM1CBCHwdwWLnatT26Qhvy0ZOY59Zn/zy5zQ=;
        b=bi/gPMnIWVrHYWf5apQhbEinQZxp9DmwE+aaDB85mDPU57kA9DAsbS47UCuiz6UywM
         0c5OXKU1jIcHhXq3rfDBF+6/ql7gT5CO2lvSK5VRHTXhB0DgSbZbtOq3vPqlG9f0rFqm
         o2KKOvk38kX57ixECiRmJANIANEwCHQRdibLINteGltfas/VkmEE42fj67CieOrYGEy/
         xd4HGWTWISaNO2OSmcDgtVH3Rf4uZJU29iRA14CxYA5X+cau/pBB0SyIRXl5Jt7QzSe1
         wLMg9mKUMq481XJTZzTkzTsPNzOE8Bl5CnveflN7QigNbgfj7AAwL4+niiXxVi5oDk9T
         Kdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732029345; x=1732634145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5UnjguskM1CBCHwdwWLnatT26Qhvy0ZOY59Zn/zy5zQ=;
        b=YgB2p5YA3pHesLTzTp40qs1IrAN8zge78txVXmi9KRAJEchF4ypMJMruZX/CJqoLf+
         tMSfsekpyEC0iBKEMn9mweYLLdHnAqx6hdML8icD+ScWaq7B15vxffGMf0b4EhrVu7B+
         TeYlEnKjYe1lyrqv6ZwYXhQ/A6X8R7KaTZqdUJ167Hu1EG6vtpkKegSrGALzlQuuplIy
         YGGQx3FC+DbbEPti/TDfTft0uk5i6BUwmSziFbKg9p04aN0Q+OtBTtMZWZFNTPWAEkpa
         rvCpVADWrnRnhnY/X4mG89kPjNsihdKCwLgLpnmxS2CcGEFz0yrhRkLOmtPSZBRqgzkS
         VJbg==
X-Forwarded-Encrypted: i=1; AJvYcCU6HmHEtcMtaXgluKNkvm93xNQP1H8CCSC3r7pm3kWlVw0tYza4yJ3At18nPxN8oRlvBuo+wvrP+QEuffBYBpyqqROB@vger.kernel.org, AJvYcCUoRoMPSGb/mIPonO2M8OC3k/PVmGJuK06/K2oa40GlV3DZ18wC9lcZU8rbNqlVyz9BOupNyynIpNAHf2BE@vger.kernel.org, AJvYcCWGKzt3GsPzOMmHBuZyqN9GqbmirwZZh4GVSCGOtZXbE/OTSifjOLLTGKKrHPw9Oe4bX9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx/x1kNnueeWaxxRiZOVWDSfja4S9swELwpPCWtESyySy5D5l0
	SMKnxN2tZ7hwH31DI2epICbqEPAc0McpGNubZbORYbOuQv9xgNhd
X-Google-Smtp-Source: AGHT+IE9Y7pxj33K3yA6gYgW+k/j0jo42x8TApKD/yxEDkHrWGgKpdhfKl+F/IJjX4y7KkaWTn5wfA==
X-Received: by 2002:a05:6000:4814:b0:382:4a1b:16de with SMTP id ffacd0b85a97d-3824a1b19e2mr5228088f8f.21.1732029344459;
        Tue, 19 Nov 2024 07:15:44 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38232ec369fsm11374271f8f.70.2024.11.19.07.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:15:44 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 19 Nov 2024 16:15:42 +0100
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC perf/core 05/11] uprobes: Add mapping for optimized uprobe
 trampolines
Message-ID: <Zzyrnvnw1I8HfAYN@krava>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241105133405.2703607-6-jolsa@kernel.org>
 <20241105142327.GF10375@noisy.programming.kicks-ass.net>
 <ZypI3n-2wbS3_w5p@krava>
 <CAEf4BzZ4XgSOHz0T5nXPyd+keo=rQvH5jc0Jghw1db0a7qR9GQ@mail.gmail.com>
 <ZzkSKQSrbffwOFvd@krava>
 <CAEf4BzbSrtJWUZUcq-RouwwRxK1GOAwO++aSgjbyQf26cQMfow@mail.gmail.com>
 <20241119091348.GE11903@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119091348.GE11903@noisy.programming.kicks-ass.net>

On Tue, Nov 19, 2024 at 10:13:48AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 18, 2024 at 10:06:51PM -0800, Andrii Nakryiko wrote:
> 
> > > > Jiri, we could also have an option to support 64-bit call, right? We'd
> > > > need nop9 for that, but it's an option as well to future-proofing this
> > > > approach, no?
> > >
> > > hm, I don't think there's call with relative 64bit offset
> > 
> > why do you need a relative, when you have 64 bits? ;) there is a call
> > to absolute address, no?
> 
> No, there is not :/ You get to use an indirect call, which means
> multiple instructions and all the speculation joy.
> 
> IFF USDT thingies have AX clobbered (I couldn't find in a hurry) then
> patching the multi instruction thing is relatively straight forward, if
> they don't, its going to be a pain.

I don't follow, what's the reason for that?

jirka

