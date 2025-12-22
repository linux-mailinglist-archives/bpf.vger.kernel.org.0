Return-Path: <bpf+bounces-77285-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CC5CD4EC8
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 09:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEC643009421
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 08:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BFD30B52B;
	Mon, 22 Dec 2025 08:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKoc3m1q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3887B30AD1A
	for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766390593; cv=none; b=uHfJWUZ9eukHkHPPbb64hbkHDu4P96sScPsMAaskxSz3065TVI8vnpBAY9oe+NbkGEwU4u4Tjy8bYBWNmMJsp0SFOWIB/v/PeoNjEFSdOb6rPDQSRFVYhR47mE1/yphtc3i2cU6tnbLHVkrSZBo4a+9KsdWd3igJnXJ2soGNTRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766390593; c=relaxed/simple;
	bh=u2adXUBp2SeqqhB2kVGsCuKLjCBT5Qy7mm7YBd0yUcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e4EPiJ/SV39TsJFgSy76ZouKne3c26eT2ocrYBUEoqChAYYR9kfGkNje/uWfzDFYpfMC52EBIKE25hDsxWDdpRri4q3MbPrwACoy/cpZEGa+yr5kZsSa/osf0N62bQ7XQqxo5YzENcs0r0KREJEpzAkayt6KsmgdweB3yz11XoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKoc3m1q; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7fbbb84f034so2728826b3a.0
        for <bpf@vger.kernel.org>; Mon, 22 Dec 2025 00:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766390591; x=1766995391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S17DRa2h+/R73ieVf7xBn3BELlMa+wdtLCYGLGZ2+5w=;
        b=SKoc3m1qSkuZEhrVHBVp6zEJey76VJ5cNVjDB6OEJVZZJD0Edgerzrmz1OkNExsZQr
         CxC+kToJA7e96B6W2/XOdWvWsFh69ceD9AtVtvzyItZG4nR42pHbS/xodFNFn9IKem+Y
         GrkwFGjZBf9HkCgQIrEU89XR4xoTJXkMfc4XhsVGbOV54hZit6wC2Eif1J91ZPRmmcKp
         z5cjsdBNOH7k4tXV29Wol3YabkZ3EKhEPyLXMXxYqkQCsK6ypbnRRW0shUlAGTxcJ8fO
         KOdF07N7IVAcN9uMoUMaj4ZQk+K+aw6ITG03vojdsKu3q7Ft8ANBAe3ilrk1qllvR0Zk
         gUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766390591; x=1766995391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S17DRa2h+/R73ieVf7xBn3BELlMa+wdtLCYGLGZ2+5w=;
        b=Z0prjGcTlWeGyq18x1QTY4YK3+0xBfaI3S3Wy/0MTp+BXQIhxxmWnLDNespumF47Fy
         De9+Fzg9Axr5JMgLlaMvLBoOsFHvuTN3CC8YZFLFgL57rPKGVzy2s5EevTEuBNXqSQff
         KTNbN6e9vKH73OrlI0xQcpknRNZ6JMsOQ73lFxSeLAIPyoF6aFDK+961UPRxPzi5Ig31
         ERPXixvwQLD7Ezg9t+w5W5vxsblgaTery/a9eEVQLTdo3rf3BnS1KIit/OSpyFsTReTA
         eQjgOdrFsrInOvAsB/V+g7exWSbfPEtl4BosiF2kjoSwDba+svXTUfWSboVCNILBbNnZ
         aIvA==
X-Forwarded-Encrypted: i=1; AJvYcCXLBo/ddL8NkHts5y/n+cBdr6UjGNjEoM0c40uqr5fLaw4kZvvkQmd/PyCtXgg02bJ6Guk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXuJENFLpt4+Lx9ZdOvpeHfxJi5cUN4wKFj27gOE41vSgoPxkM
	TXEoiMwySrYvmoEmo9NnIMIYjVPvCUCbbs2yW6/3qLdbOea5kBJoaWV7
X-Gm-Gg: AY/fxX4weecM+4zLD161ySb07Yuo6r0Dqvcwj/Ohqa60rHxWCkpOIog0X6i4I9c5lW6
	6IEUkzEFsRmdHYAbf1rJ8dM5nP+9jfegd5bpqoV9KqsLf4xMrqbXRvWVHgdj4vIhJ995k3esrv4
	GVHistFHS5XKttfN3LcklC1etxFLu6pDicu26IWXX4iu2F7CBemBUs9bDCZrYnKU7auLkiXLppY
	tGkbiMu7To0ykcaqUOYEdf+4MQwj5BzesKFYVj6cwrvroIbJ9qLz7hgAOXxHABg1Q7ymUJPQhyC
	wAPXrKqwunATdncXWK7j1kTVjyHi59N1LlSvVwAxplb9pkcQqaRywXrYum4/Tdb9vlhGUBK8l3p
	zJkaDheSlhFq50VqWgIfy8+E1HXcBLGMi5/jQuXTYknjfXGXV1eDH5snM7Ct8lc/2GZFPe5fkqP
	VXr9fpuHzJhTAYl3q1qnYLxdgYcxbjj1gd//c=
X-Google-Smtp-Source: AGHT+IEtrG0VqTiNJPqK10jmschrRXZ/4HelRXlYEPIKhnktqJ/0oCYzH9sApYMw5ja3HXigyYybeQ==
X-Received: by 2002:a05:6a20:4311:b0:350:f9c5:f90c with SMTP id adf61e73a8af0-376a81dcc1fmr9044567637.27.1766390591415;
        Mon, 22 Dec 2025 00:03:11 -0800 (PST)
Received: from mi-ThinkStation-K.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7961b4d0sm8408044a12.5.2025.12.22.00.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 00:03:11 -0800 (PST)
From: liujing40 <liujing.root@gmail.com>
X-Google-Original-From: liujing40 <liujing40@xiaomi.com>
To: menglong.dong@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	liujing.root@gmail.com,
	liujing40@xiaomi.com,
	martin.lau@linux.dev,
	mhiramat@kernel.org,
	sdf@fomichev.me,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH 2/2] bpf: Implement kretprobe fallback for kprobe multi link
Date: Mon, 22 Dec 2025 16:02:53 +0800
Message-Id: <20251222080253.2314895-1-liujing40@xiaomi.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <24197762.6Emhk5qWAg@7940hx>
References: <24197762.6Emhk5qWAg@7940hx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 19 Dec 2025 09:57:37 +0800
Menglong Dong <menglong.dong@linux.dev> wrote:
> On 2025/12/18 21:06 liujing40 <liujing.root@gmail.com> write:
> > When fprobe is not available, provide a fallback implementation of
> > kprobe_multi using the traditional kretprobe API.
> >
> > Uses kretprobe's entry_handler and handler callbacks to simulate fprobe's
> > entry/exit functionality.
> >
> > Signed-off-by: Jing Liu <liujing40@xiaomi.com>
> > ---
> >  kernel/trace/bpf_trace.c | 307 +++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 295 insertions(+), 12 deletions(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 1fd07c10378f..426a1c627508 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2274,12 +2274,44 @@ struct bpf_session_run_ctx {
> >       void *data;
> >  };
> >
> > -#ifdef CONFIG_FPROBE
> > +#if defined(CONFIG_FPROBE) || defined(CONFIG_KRETPROBES)
> > +#ifndef CONFIG_FPROBE
> > +struct bpf_kprobe {
> > +     struct bpf_kprobe_multi_link *link;
> > +     u64 cookie;
> > +     struct kretprobe rp;
> > +};
> > +
> > +static void bpf_kprobe_unregister(struct bpf_kprobe *kps, u32 cnt)
> > +{
> > +     for (int i = 0; i < cnt; i++)
> > +             unregister_kretprobe(&kps[i].rp);
> > +}
> > +
> > +static int bpf_kprobe_register(struct bpf_kprobe *kps, u32 cnt)
> > +{
> > +     int ret = 0, i;
> > +
> > +     for (i = 0; i < cnt; i++) {
> > +             ret = register_kretprobe(&kps[i].rp);
> > +             if (ret < 0) {
> > +                     bpf_kprobe_unregister(kps, i);
> > +                     break;
> > +             }
> > +     }
> > +     return ret;
> > +}
> 
> Hi, Jing. I don't see the point of the fallback logic. If we want to
> use the kprobe-multi, we enable CONFIG_FPROBE. Is there any reason
> that we can't enable CONFIG_FPROBE? As you said, for a "old kernel",
> I think we don't introduce new feature for an old kernel.
> 
> Besides, did you measure the performance of attaching bench?
> You will register a kretprobe for each of the target. AFAIK, the
> kprobe will use ftrace for optimization if we hook the entry of the
> target function. So I suspect it will be quite slow here.
> 
> Thanks!
> Menglong Dong

The Dynamic ftrace feature is not enabled in Android for security reasons,
forcing us to fall back on kretprobe.
https://source.android.com/docs/core/tests/debug/ftrace#dftrace

I will provide the benchmark test results as soon as possible.

