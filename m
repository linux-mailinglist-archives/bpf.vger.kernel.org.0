Return-Path: <bpf+bounces-26261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 122C689D50C
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 11:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 431B81C22C35
	for <lists+bpf@lfdr.de>; Tue,  9 Apr 2024 09:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C277EF1F;
	Tue,  9 Apr 2024 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KpQFxEST"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB737E78E
	for <bpf@vger.kernel.org>; Tue,  9 Apr 2024 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653338; cv=none; b=aB2FN6TWQk8JKum6xQ0cVGWQqTqqHwa0ULzzj6/xG2gofSc7lO18CCUGh73bQfRRbPoqQwkQhW93HlYeOiUxrryLeKKI2+rg0y0MdU5wW6CiQXxFwS+LkgkPd8Cp9ipUW6DBO1wH4AqfN/iUDULOF1AFJEWxNmqErnyQ/WWW6c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653338; c=relaxed/simple;
	bh=euhpq35wFK9rmemS5feCCQzrNuJRo+rAgFPHnTkC0AQ=;
	h=From:To:Cc:Subject:In-Reply-To:MIME-Version:Content-Type:
	 References:Date:Message-ID; b=BroD4Dp/fyBif9vl+omwd8HXpHzRESDDZC9Lg0x7P1qUAJD5hUl41Q8YcNv8pmj2vDv77QN5zDJQsowzWC68SBkjAl7oFL32LAJ24AT23Nz1UfPDI6p54+x4oj+ArM7D+ns7T3T25p7yyDJQ2sqycdMMQZHJqs4WcwBFP12vbis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KpQFxEST; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712653335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=euhpq35wFK9rmemS5feCCQzrNuJRo+rAgFPHnTkC0AQ=;
	b=KpQFxEST1MCnVLCSyly/XAxCsNUpnTs2CPXMKqFo4q83hy1A0QgReJY/wklwqGYqFDeuyE
	MTEKNSii8HspAk6j3HdSc1M4c69DgXbbajeFMpTa4X2/iPR8EZ8C6gCpyaYmLELklgOg+Y
	rdw4WryVTm5KOVY4B3+vge7HWWS7oUA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-cOQv1XmSNEmotc-umIewoA-1; Tue, 09 Apr 2024 05:02:14 -0400
X-MC-Unique: cOQv1XmSNEmotc-umIewoA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-78d3352237cso770251085a.1
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 02:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712653333; x=1713258133;
        h=message-id:date:references:mime-version:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euhpq35wFK9rmemS5feCCQzrNuJRo+rAgFPHnTkC0AQ=;
        b=nklTizm4UAX2MvSSW5ieUhJzLKK/xtHoFqXS/JOcBLFikLAyYy2HfN6jx5O6lQ/9XF
         rdlmZ8WqUKQsy6j/4cHtMCDNE2I7eVzE6bPI16qANqow8SD4L9xHGd9+ZsbLE+G5zfsr
         7glT1wcO12WOFfWwEbqAu4JEVUdimwH5fajI/QMKqjt54cB8zvNCrbFawkzAMTgemyK/
         7+PmvVK/+dpw8fupDTnc6AjK6qZHDAtUc476do2jevd95DFdzScR3KehGlLJqA5uKbLZ
         +PV8Uc/e0kCNbvnjKhRKACTLWCSKEzud5oLzImBO+yEZKIHold9qXGkXBTDlubx73zJf
         OylQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdT0QQJxrPqv+DQRn2CqbjXw5qK9UG5J2IBbjM8FioU9f31g5bieWkV6vhsSN19p03F7DP/LKfXFfbuDzppkVx/DWL
X-Gm-Message-State: AOJu0Yy6u5o7MjXBsHUrPseGx0Ak6YBs5ZuRhjH8LOA7HZxPVzbu55PV
	6V4eqbzt+d2qOYihQ/3Jzy0vBUvqhpGshO1DZTqOxOkF7MVQdHgMwqjKR0a444/KWPSwiU+THFX
	YmjDIqrcHynY1vrH/7JOYNqT7EAsdagSPFlwLLpHTYA8ALhXt+w==
X-Received: by 2002:a05:620a:198e:b0:78b:b0c2:17b6 with SMTP id bm14-20020a05620a198e00b0078bb0c217b6mr3047974qkb.11.1712653333517;
        Tue, 09 Apr 2024 02:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfJ9YI9fXu3bzCu+1ZKDrEFWqdCINgH4B4WK2Fj7Lg7ZxEGYh8Q7hvW22usdjnP1/pni2urA==
X-Received: by 2002:a05:620a:198e:b0:78b:b0c2:17b6 with SMTP id bm14-20020a05620a198e00b0078bb0c217b6mr3047929qkb.11.1712653333008;
        Tue, 09 Apr 2024 02:02:13 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id h6-20020ac85486000000b004347d76f43csm2678126qtq.79.2024.04.09.02.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:02:12 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Joel Granados via B4 Relay <devnull+j.granados.samsung.com@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, josh@joshtriplett.org, Kees Cook
 <keescook@chromium.org>, Eric Biederman <ebiederm@xmission.com>, Iurii
 Zaikin <yzaikin@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
 Will Drewry <wad@chromium.org>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Petr
 Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, Sergey
 Senozhatsky <senozhatsky@chromium.org>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Balbir Singh <bsingharora@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Joel Granados <j.granados@samsung.com>
Subject: Re: [PATCH v3 06/10] scheduler: Remove the now superfluous sentinel
 elements from ctl_table array
In-Reply-To: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-6-285d273912fe@samsung.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
References: <20240328-jag-sysctl_remove_empty_elem_kernel-v3-0-285d273912fe@samsung.com>
 <20240328-jag-sysctl_remove_empty_elem_kernel-v3-6-285d273912fe@samsung.com>
Date: Tue, 09 Apr 2024 11:02:04 +0200
Message-ID: <xhsmhil0qaoz7.mognet@vschneid-thinkpadt14sgen2i.remote.csb>

On 28/03/24 16:44, Joel Granados via B4 Relay wrote:
> From: Joel Granados <j.granados@samsung.com>
>
> This commit comes at the tail end of a greater effort to remove the
> empty elements at the end of the ctl_table arrays (sentinels) which
> will reduce the overall build time size of the kernel and run time
> memory bloat by ~64 bytes per sentinel (further information Link :
> https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)
>
> rm sentinel element from ctl_table arrays
>
> Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>

Tested-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> Signed-off-by: Joel Granados <j.granados@samsung.com>


