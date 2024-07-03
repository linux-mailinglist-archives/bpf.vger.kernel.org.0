Return-Path: <bpf+bounces-33781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 310279265E8
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 18:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81DD3B28566
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 16:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D861822ED;
	Wed,  3 Jul 2024 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CchXGZN7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B3D17C7C;
	Wed,  3 Jul 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023647; cv=none; b=bhfOkyHX6HW0vrxqLasJWeZaK6R5ToTx8FTK+Pac0fxzA2287u5/yc36DgSmmtfvqVPz7oH3VKVvzIG1W6/vParOJ9CG/zv3TvVh53bx3++4qK6UEGFvwePvl6eZwR2TrFLXTA/HHhhHK6Qd/myx9y7z2AxLLpwQX76PZpcUE24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023647; c=relaxed/simple;
	bh=wwFT+vz81q5073dVZ1ppSrdYkyQllN4uMfPUMuY8sGM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOQNhZqMpGvdXIVMjmrQuLnfW+14vnVpXIe2ugZXTZLhOolrf10UR1UXphquuDUnGIm/osjAdfBptr8hcS8MrHYsqZysjeqOXi7kdzqJkTrGvs+8N6XKNxMdzFx1of5Q5t5Ti9qgp9H42MSnPQxED/uPPRNYk3ww9A9sIuowh/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CchXGZN7; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ee7885aa5fso22132231fa.1;
        Wed, 03 Jul 2024 09:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720023644; x=1720628444; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v6l054JVIhkosfS6xjtkQ8TNQqgCYBV3oASoIl/CMIQ=;
        b=CchXGZN7MISAzlRkgz12MQNdSA+bZKmvZwLlJIoaZcHzMsGv3EULtVKnC2uogj22tI
         ZcjE3ey6TNHtziX+GKwSOcZsyo0YXG2QM7IgC/SI6TuIav5hbzJNQ/PMzlvSJrtkfYzY
         uB/I7Pb26d5KzOIxxN5qENvfhJrfkEBPnxQzHbzowmGx2t6ZUAzP01CgSyTdWwk9M1Pz
         4y+VHXwjJGWPZTkZ6uZg0UgEkHk6r2jaZ0MdiQMAfKSXfoyVtL5PE0XUf2XuB95KvJkv
         TBMR2ohTuphXUsbvRuR0kzmdDKsL11DYAbrX+Q9++FIQ0VAW+GMLa7ap0fen0NSvJ65d
         W4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023644; x=1720628444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6l054JVIhkosfS6xjtkQ8TNQqgCYBV3oASoIl/CMIQ=;
        b=FTz+nnjMhd3WRJl7LdydpN0chm8E2smutsypzkHvW17jXGG9/IlRaOoTrc8Wrqneea
         fOeNcFoq4i7iXyr5cG9qIJsvGxNU4b7OMgyxtjoY2RxVJYZ6UH2itf6UrZlInOd0oGjx
         crcqyVKN4lzU80AKbCg3zk8cKT6Ox4Z3p1QIHleEOerfbWanWvDc/n/PB+x8qsm/OBFK
         IXGsZdcnIxtMgAaG3Kae58VnRavdpgfXicF/ooKjUFQWgDvHs9tvK385l01oweiXRQW9
         Do7RcjUlG1FFmw1BtqihnbZF1vhnx4DdITkuRz07npgo/t9qIIhu4L2HwvFPQkA2SGSG
         GMdw==
X-Forwarded-Encrypted: i=1; AJvYcCWNXwtxLPap6RjB1dKW51VNrAoSAvLWtIgliVhb/e3YeLm7Q9071emnbd/cXuEgmWQDlrZxVf7jX3akSHpMEdy8S5sBUnEnMfXJXVWCyLBIjjBLPoUW0pQ/pxIfSLqjhuk/WCOCAsL8A3RivcKZcwnEhFrCzKREcsgLwWYs4+VY8GgHAUvv
X-Gm-Message-State: AOJu0YzoURcB43Ewepa7QtxXthWrojMi022nFJ+YXXGR7IlhtPOYaEuM
	lKsGACVDv7AUdtTieyiiFJMONcB/TBom9VOoOTLvfR2j6X9dJquX
X-Google-Smtp-Source: AGHT+IHF602ROVoMJ5i/7KWiAX0EbFAF1zyRWMZ68q+6idsjw7RsAzLr+FNYROMIa1HOy3OmGVqm1Q==
X-Received: by 2002:a2e:bc19:0:b0:2eb:d924:43fb with SMTP id 38308e7fff4ca-2ee5e6bc6f7mr90705151fa.41.1720023643632;
        Wed, 03 Jul 2024 09:20:43 -0700 (PDT)
Received: from krava ([176.105.156.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a073sm244278305e9.32.2024.07.03.09.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 09:20:43 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 3 Jul 2024 18:20:36 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
Message-ID: <ZoV6VK9PiryYZw2O@krava>
References: <20240701164115.723677-1-jolsa@kernel.org>
 <20240701164115.723677-2-jolsa@kernel.org>
 <20240702130408.GH11386@noisy.programming.kicks-ass.net>
 <ZoQmkiKwsy41JNt4@krava>
 <CAEf4BzYz-4eeNb1621LugDtm7NFshGJUgPzrVL7p4Wg+mq4Aqg@mail.gmail.com>
 <ZoVu1MKUZKtPJ7Am@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZoVu1MKUZKtPJ7Am@krava>

On Wed, Jul 03, 2024 at 05:31:32PM +0200, Jiri Olsa wrote:
> On Tue, Jul 02, 2024 at 01:52:38PM -0700, Andrii Nakryiko wrote:
> > On Tue, Jul 2, 2024 at 9:11 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Tue, Jul 02, 2024 at 03:04:08PM +0200, Peter Zijlstra wrote:
> > > > On Mon, Jul 01, 2024 at 06:41:07PM +0200, Jiri Olsa wrote:
> > > >
> > > > > +static void
> > > > > +uprobe_consumer_account(struct uprobe *uprobe, struct uprobe_consumer *uc)
> > > > > +{
> > > > > +   static unsigned int session_id;
> > > > > +
> > > > > +   if (uc->session) {
> > > > > +           uprobe->sessions_cnt++;
> > > > > +           uc->session_id = ++session_id ?: ++session_id;
> > > > > +   }
> > > > > +}
> > > >
> > > > The way I understand this code, you create a consumer every time you do
> > > > uprobe_register() and unregister makes it go away.
> > > >
> > > > Now, register one, then 4g-1 times register+unregister, then register
> > > > again.
> > > >
> > > > The above seems to then result in two consumers with the same
> > > > session_id, which leads to trouble.
> > > >
> > > > Hmm?
> > >
> > > ugh true.. will make it u64 :)
> > >
> > > I think we could store uprobe_consumer pointer+ref in session_consumer,
> > > and that would make the unregister path more interesting.. will check
> > 
> > More interesting how? It's actually a great idea, uprobe_consumer
> 
> nah, got confused ;-)

actually.. the idea was to store uprobe_consumer pointers in 'return_instance'
and iterate them on return probe (not uprobe->consumers).. but that would
require the unregister code to somehow remove them (replace with null)

but we wouldn't need to do the search for matching consumer with session_id

also it probably regress current code, because we would execute only uprobe
return consumers that were registered at the time the function entry was hit,
whereas in current code the return uprobe executes all registered return
consumers

jirka

> 
> > pointer itself is a unique ID and 64-bit. We can still use lowest bit
> > for RC (see my other reply).
> 
> I used pointers in the previous version, but then I thought what if the
> consumer gets free-ed and new one created (with same address.. maybe not
> likely but possible, right?) before the return probe is hit
> 
> jirka

