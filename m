Return-Path: <bpf+bounces-44837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F6A9C85B4
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 10:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D000B29555
	for <lists+bpf@lfdr.de>; Thu, 14 Nov 2024 09:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EC51DE3C5;
	Thu, 14 Nov 2024 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6HWEDr1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F02E573;
	Thu, 14 Nov 2024 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575327; cv=none; b=UWLrmyCQI4Jevzcp8wwgqjmYH9UbeyG1NAtFz9nhTR8xcyqzhrPqjyVjL5XpeNxB75FweZNnotyhBez7Fz4mUrF+d7mUeeRNjEe9q+MYINPcL2N4wu+G7pXFRbg0lMocGPB4zM8+56heEH29u7qhwM+pRxq/4Rl5fUEA+c2Aa74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575327; c=relaxed/simple;
	bh=rNSB/Gv3XTfSm3CiYEJhNy/ZDpquJUDPkzURBFBo1y0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPVX6shqIMf0jcycJKhcj3miG4T0+ka1zbeenGNGMr/mfRUjdAGAQPbO98CbyYEmHl2sPkeMsRvs6pp8Kal5ZDSIGZu0LkPLKv+YMwd9/OkEovGoz+lMATmNSOzk/QvI84BnyJ4uhMHrKAzohDJ9hFZod/siLK1CwLg98ZeZlUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6HWEDr1; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cefa22e9d5so394871a12.3;
        Thu, 14 Nov 2024 01:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731575324; x=1732180124; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xj4J1nAwgNgBUfIb69qUsHb/4NoMVPegAyL84SVWCWs=;
        b=l6HWEDr1UHmpK1hSBGfKIouyOvJDI7ggV8dlj7IuYuKyJHOwG1p7EJ5y8NL8fCPR08
         POt+YHmXMC8r3mArvfx8dK/fyz8b8/607Bgz16K1D+EbaQYJhwgF376jn2pn5TEit+z2
         2h6Nh7/orI8C3zxwm8UziePakuVSSTJ7C/PAzL2uY9NM9V002IHN5oKoHWcC4GJAouhi
         S2GZCLm0LjCqxrj+4GTF+phZcTTgg5yEpest4BkkkZFeHvzJaOiBKartV9Bi71q8SHY3
         CvxKyQKq8QaThipyBqpiHIPEkc4yQv/0q2dpWiX3KqW5UTZ7+i0wkt4s1IQY3gZ4mGCL
         MJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731575324; x=1732180124;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xj4J1nAwgNgBUfIb69qUsHb/4NoMVPegAyL84SVWCWs=;
        b=E58fJ/pL7zi+Dk4hWTmK7792zPlXy7adxzGccKXR/thF869DHBEo3gYYmTpAfUOT2E
         Dol2ISJh/DHnCxyDOmIMKn8CkJctNoOnGAqH+GKvKyyyHwhFqJIzreJf5stkbsoDtfHc
         c+c3d8sDQJAk+8tuuo36+o8IRc0FQ4F66T0+okbf9KxHoTq2gxBQpSfa1A7qVbpkiyht
         6gyGWti6hmxy1ygDL2du494x7lMSlVUGpigWQ6luBWF1C6qWObBlQo3UouRemiM8oQq4
         +unn6MlSYzYvIzWNmUfWDFsKYfD+E8MPINqeISURx8a0y1GHYug1MXwlX8bT/HgwixL1
         2Lkw==
X-Forwarded-Encrypted: i=1; AJvYcCUgCzVcdHE+KA9DUwuACiI+kQHFwpawPry7pinPaRVyQfZOwPRl8FbHPHSYu5p3R5xU8FG9pr0PSyOEN1kbn00SiEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVw0yLCka+yPlcBvYMz7CM977n8Q9zv11RVaVrNha8k68OmjI1
	KKl6XJNE00hkp6qAL5j1jzDbJy7zY+0xde3ziLrgNjQIsBy9vz8V
X-Google-Smtp-Source: AGHT+IFVzCc4lDijDDqQfVvtFhSov9oH3a2sfIZOWTwyiICjVAEbZCz/xR0MOjGmf0MW/pU9dABojg==
X-Received: by 2002:a17:907:96a2:b0:a9a:422:ec7 with SMTP id a640c23a62f3a-a9eeff2542emr2011844266b.32.1731575323548;
        Thu, 14 Nov 2024 01:08:43 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e001715sm39385466b.126.2024.11.14.01.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:08:43 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 14 Nov 2024 10:08:41 +0100
To: =?iso-8859-1?Q?Sebasti=E3o?= Santos Boavida Amaro <sebastiao.amaro@tecnico.ulisboa.pt>
Cc: bpf@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: uprobe overhead when specifying a pid
Message-ID: <ZzW-GWh7Iqp-AxGA@krava>
References: <66ba4183c94d28f7020c118029d45650@tecnico.ulisboa.pt>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66ba4183c94d28f7020c118029d45650@tecnico.ulisboa.pt>

On Wed, Nov 13, 2024 at 11:33:01PM +0000, Sebastião Santos Boavida Amaro wrote:
> Hi,
> I am using:
> libbpf-cargo = "0.24.6"
> libbpf-rs = "0.24.6"
> libbpf-sys = "1.4.3"
> On kernel 6.8.0-47-generic.
> I contacted the libbpf-rs guys, and they told me this belonged here.
> I am attaching 252 uprobes to a system, these symbols are not regularly
> called (90ish times over 9 minutes), however, when I specify a pid the
> throughput drops 3 times from 12k ops/sec to 4k ops/sec. When I do not
> specify a PID, and simply pass -1 the throughput remains the same (as it
> should, since 90 times is not significant to affect overhead I would say).
> It looks as if we are switching from userspace to kernel space without
> triggering the uprobe.
> Do not know if this is a known issue, it does not look like an intended
> behavior.

hi,
thanks for the report, I cc-ed some other folks and trace list

I'm not aware about such slowdown, I think with pid filter in place
there should be less work to do

could you please provide more details?
  - do you know which uprobe interface you are using
    uprobe over perf event or uprobe_multi (likely uprobe_multi,
    because you said above you attach 250 probes)
  - more details on the workload, like is the threads/processes,
    how many and I guess you trigger bpf program
  - do you filter out single pid or more
  - could you profile the workload with perf

thanks,
jirka

