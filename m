Return-Path: <bpf+bounces-57814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BD1AB0638
	for <lists+bpf@lfdr.de>; Fri,  9 May 2025 00:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E124C021B
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 22:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813F122B8D5;
	Thu,  8 May 2025 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpU5bQek"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4872F1E4AE;
	Thu,  8 May 2025 22:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746744994; cv=none; b=md7h43fTfU2R/c4t/0ChMcued5iQKjww2ch1nA2v2K/rKpKXlscSIh7LVEbPpNpqjk+DVf5GEhuH/W/xlkJFCdhVpP5wci5eR1UgUljbEV0/yHRXKVfJGh6OUu5jXoAwOFhb2WEGflwNGWFgmuKPf36New9Q2ofVTHwEIvjAAus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746744994; c=relaxed/simple;
	bh=3JAhOTyJuOJXjyU4iucqXjAjG7y2zOUxpPTAlT8/GNc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYKdc+GX4MynO5DKppU2rBwcFXYMVV90T7CdvUmtFepoj20zI0JyQDoTLMMIwaxms+heywOYDWxGS5sHyCx/zmIdxMbSx5/pOI4P3futcp4sEw0cTkgWzCYY2h2qz/OyzcPy6PW2bYg9PBdMlLcptvtxLFgQPcc1I1MBo9+mlDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpU5bQek; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acae7e7587dso221047366b.2;
        Thu, 08 May 2025 15:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746744990; x=1747349790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4TtA7SOZEBo9Y1sz3dMuVzc2E+0F5LFx7k01BWDKL98=;
        b=fpU5bQekXvNxbP2tqnYz/BfXBdp29QkCp/Eq1lygOM2iJwwbYhLFZ1q07w4uKJE+Ka
         Uiwr3///aAsp00xMzL13Bwlf2TKUZ5tD8nADkwjztMsWLJPR/zuOAunjcnaLd38IkYEw
         31EggxkPaDNu6epDd3fbYHlXSOPdL66xBExYjwsYWdUsdPwTQGT8gq/hTLQHPzFWUgDr
         gODwTjTXWt0W54EhGGZ56NRPoUw6cuTdiAo7hy5/8n7pRIKIlr5GhqqDK9ym8IR6i0wQ
         N/VpF3/wEL3ui69gLnjWtjvhJI2WJGBAFJ02tstF4hn34Lfuwi407t+lVl3F93NgI+wr
         csYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746744990; x=1747349790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TtA7SOZEBo9Y1sz3dMuVzc2E+0F5LFx7k01BWDKL98=;
        b=I9lBRWRvWU4tw+9QwIiYBOwXKadA6gAqMHPptoo8PxobLxKKNuc3oB9czGD+fk/kLc
         ExlGfyeXaMHdvuk3lj3S6vjg7263tJ9Bb/ClkbC05SwCMHzcd5KHuVjdgj4W6as6Rtmd
         o4pCzKlDR2iXhAOSvyIL2T3Dt28Un+H013Kmx9lmV5grAblc1d0sQpp0GFuqa+X7qqe7
         l5S/0+3pfBiLFjdheQOMhgqbaAwB9ELDQvppLcazmfDlbMBhkSfzPGU1b9MJa8HJiWVQ
         M+RWVuMgnmUj//IiCifRDcvHPyec3LJpSMb8XyVvDKAjweYF9N2phpC6RiZXT048Ey9w
         77qQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/ESUsJzaie1y4ZYkyl6KZ9XXwlv9fOQEAmieE7a4mT2fPGme1G/HspbqCD6lvZ/9NpJM=@vger.kernel.org, AJvYcCUfK49XkFrP9mA6iiE5quCeZWLErZqFRy4X/dP90HmLK0f5kJlvkhgY3XxahNP8xwrwWY1WFWovTXdmjnNLgI6NvSJC@vger.kernel.org, AJvYcCXTAKu0/KZ+yBZ4pMavyUD5XBYTvGAhaUUMT+F4lAl2XBqmJmwF21WSzA3/wFD16aBq8dQW/tAMDl/wLAgK@vger.kernel.org
X-Gm-Message-State: AOJu0YyNlCVxacTnf35/YNj8N3R8gBIDJXOPMkp0ncTIhl83gCXYUhjn
	WZOxkKk2ElUpsLfN3dXKtDbJQbNCiNr2EcQ3nXug0jt8x454M22W
X-Gm-Gg: ASbGnctapd77Q0mDyK60nhcAMs5uQTFiSjs450W0mQPrHT8eVjfwVivE12eqqGYdYnw
	LtJl3/qvILkXF+hkgDbrbuEVFu7VpmiTFpW6M+zwy7JEIMLh/3gRAfpLdC+8NeY13eIq3GohllB
	AOxZLKYqFzt06cWWTYygqyVHL/zzJONMCaIXn5J7NNNn88Qlt0AMNez6TlNi01BR0PVbHj6rKvL
	gFzyj2P682FPLZBSc2JIRhXeGA0WexNe6E2OehveTdtcGfW4A3Z9QtuYEx92qHd7c0r8oZdQZi7
	LnM9QTECGOsRc1Z/c8Yn7yLCNMwgKZTy4bdS1wn/nKMLYiQ=
X-Google-Smtp-Source: AGHT+IFtIpuSO8HyzNYma7DB+q71UiS1xTQzzQwFod0Yy6pwWBBgH236J4RrbrOg6RqXL9ZR/3yiaA==
X-Received: by 2002:a17:907:1b1c:b0:aca:d6f0:af0c with SMTP id a640c23a62f3a-ad2192d4a49mr124318066b.59.1746744990232;
        Thu, 08 May 2025 15:56:30 -0700 (PDT)
Received: from krava (85-193-35-57.rib.o2.cz. [85.193.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bd37dsm52778066b.124.2025.05.08.15.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 15:56:29 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 9 May 2025 00:56:27 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 03/22] uprobes: Move ref_ctr_offset update out
 of uprobe_write_opcode
Message-ID: <aB02m4ZdPGJOWatx@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-4-jolsa@kernel.org>
 <20250427141335.GA9350@redhat.com>
 <aA9dzY-2V3dCpMDq@krava>
 <aBoKnP4L-k8CweMy@krava>
 <aBoWEydkftHO_q1N@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBoWEydkftHO_q1N@redhat.com>

On Tue, May 06, 2025 at 04:01:45PM +0200, Oleg Nesterov wrote:
> I'm on PTO and traveling until May 15 without my working laptop, can't read
> the code.
> 
> Quite possibly I am wrong, but let me try to recall what this code does...
> 
> - So. uprobe_register() succeeds and changes ref_ctr from 0 to 1.
> 
> - uprobe_unregister() fails but decrements ref_ctr back to zero. Because the
>   "Revert back reference counter if instruction update failed" logic doesn't
>   apply if is_register is true.
> 
>   Since uprobe_unregister() fails, this uprobe won't be removed. IIRC, we even
>   have the warning about that.
> 
> - another uprobe_register() comes and re-uses the same uprobe. In this case
>   install_breakpoint() will do nothing, ref_ctr won't be updated (right ?)

right, because int3 is still in place and verify_opcode returns 0

> 
> - uprobe_unregister() is called again and this time it succeeds. In this case
>   ref_ctr is changed from 0 to -1. IIRC, we even have some warning for this
>   case.

AFAICS that should not happen, there's check below in __update_ref_ctr:

        if (unlikely(*ptr + d < 0)) {
                pr_warn("ref_ctr going negative. vaddr: 0x%lx, "
                        "curr val: %d, delta: %d\n", vaddr, *ptr, d);
                ret = -EINVAL;
                goto out;
        }

        *ptr += d;
        ret = 0;
        ...


but it still prevents the uprobe from 2nd register to trigger,
so I think the change you suggest makes sense


few things first..

 - how do you make uprobe_unregister fail after succesful uprobe_register? 
   I had to instrument the code to do that for me

 - I see one extra uprobe_write_opcode call during unregister (check below)
   seems it does no harm, but looks strange


current code:

   1st register:

   - uprobe_register succeeds and changes ref_ctr_offset from 0 to 1

   1st unregister:

   - first there's uprobe_perf_close -> uprobe_apply call that ends up in
     remove_breakpoint call that will decrement ref_ctr_offset to 0 and fail

   - followed by __probe_event_disable -> uprobe_unregister_nosync call
     that ends up in remove_breakpoint call that will fail to decrement
     ref_ctr_offset to -1 (and ref_ctr_offset stays 0) and fail

   - uprobe is leaked

   2nd register:

   - another uprobe_register() comes and re-uses the same uprobe. In this case
     install_breakpoint() will do nothing, ref_ctr won't be updated, stays 0
     so uprobe WILL NOT trigger

   2nd unregister:

  -  both attempts (from uprobe_perf_close and __probe_event_disable as above)
     to write original instruction will fail, because ref_ctr_offset
     update fails and uprobe_write_opcode bails out


with the attached change we will do:

   1st register:

   - uprobe_register succeeds and changes ref_ctr_offset from 0 to 1

   1st unregister:

   - first there's uprobe_perf_close -> uprobe_apply call that ends up in
     remove_breakpoint call that will decrement ref_ctr_offset to 0 and fail
     and restore ref_ctr_offset to 1

   - followed by __probe_event_disable -> uprobe_unregister_nosync call
     that ends up in remove_breakpoint call that will do the same as
     previous step, ref_ctr_offset is 1

   - uprobe is leaked

   2nd register:

   - another uprobe_register() comes and re-uses the same uprobe. In this case
     install_breakpoint() will do nothing, ref_ctr won't be updated, stays 1,
     so uprobe WILL trigger

   2nd unregister:

  -  succeeds, and ref_ctr_offset is 0


jirka


---
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 207432e92386..65bfe52ed729 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -589,8 +589,8 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 
 out:
 	/* Revert back reference counter if instruction update failed. */
-	if (ret < 0 && is_register && ref_ctr_updated)
-		update_ref_ctr(uprobe, mm, -1);
+	if (ret < 0 && ref_ctr_updated)
+		update_ref_ctr(uprobe, mm, is_register ? -1 : 1);
 
 	/* try collapse pmd for compound page */
 	if (ret > 0)

