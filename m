Return-Path: <bpf+bounces-17022-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A5C808F95
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 19:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 783D7B20D5F
	for <lists+bpf@lfdr.de>; Thu,  7 Dec 2023 18:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21B54CE0E;
	Thu,  7 Dec 2023 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3ZiRQCI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D8C10EF
	for <bpf@vger.kernel.org>; Thu,  7 Dec 2023 10:09:12 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54917ef6c05so1744022a12.1
        for <bpf@vger.kernel.org>; Thu, 07 Dec 2023 10:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701972551; x=1702577351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKA4kUGjRXNoNfOrvwUOa3+jM3apb0K9LKH+aIdAPQY=;
        b=J3ZiRQCICZOLXd1xiNmFP4/4LpRCpKuBwyM1K4xa3lchGOm8K5KMta0ebSpV3doW7l
         zlweLLWXVkq1vX/yKn/bvRYNdanF32HBkG4O/x09+64rKGL+UwHAB+Zp4FXvj4+76qL6
         pwYOeDcaQHrqU+6ICnHtDjwTmOCTXhvRWKj29k2ctM/MINvV2YGiByj+q6JhKxS5I3ah
         ueYtf28MNe659IExS6HP6tx+COoJXNQ7TV3gbaPLYAsjSc8XK4NxiMS+KpuSUZWWjrTN
         eD7XW/7CQRDq3yzR+FmuK2nILF/k0ae+pb72T37b23jf0OlqVBDXpJtVcImSKxtz//xq
         1k9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701972551; x=1702577351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKA4kUGjRXNoNfOrvwUOa3+jM3apb0K9LKH+aIdAPQY=;
        b=HmfunF1AmVMG+huOkcF1VGI2myic1X87ONb7HjWJMmG41rA+d64e5D/2YqCcFxz8Fv
         tP9YnhBJDhjh5LqfQLMNtpEScBLjWJrL1dRNJtkXwLJk068bWsYrNPa4LBJH4sehs9kn
         tbZbZPRj+MZu4JgrwPN8J0CxF/DZP0dFeI1M1XTarmt8xTmBo6OnXvoT+w46DnKVGwAL
         mAsbKAo4rFyI//m4fNXdZ2fO50LXFAYiDcDKlihdhvlR5E/iuFsd8h5wTWx6ulRGW3nj
         UYROcxxQlV13xBVqMxghRHUE9Pjrdg9NzFnxfJHQVE05TgCXD8o6YXyQYhtMgwffJfiS
         h1JQ==
X-Gm-Message-State: AOJu0YxpvdLTb4fzG/hMvCllmpt5uVH9YbGKqzuEzB1AmBfqMqPwhoKg
	tRBLXPxFKqSSMQDHQ98mUH8=
X-Google-Smtp-Source: AGHT+IHRhLX0X3sw0BToKPyOioo2joS/qfO+CXK4mWpgg5zMRf16PSvN+fXcd9HaCY4pMQim97WbdQ==
X-Received: by 2002:a17:907:6016:b0:9bd:a7a5:3a5a with SMTP id fs22-20020a170907601600b009bda7a53a5amr1014874ejc.36.1701972550974;
        Thu, 07 Dec 2023 10:09:10 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id vq6-20020a170907a4c600b00a1d5444c2cdsm38804ejc.140.2023.12.07.10.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 10:09:10 -0800 (PST)
Date: Thu, 7 Dec 2023 19:05:30 +0100
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org,
	asavkov@redhat.com
Subject: Re: [PATCH bpf-next v6 1/4] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <20231207180530.wu4kp6e66eh2t7d2@erthalion.local>
References: <20231202191556.30997-1-9erthalion6@gmail.com>
 <20231202191556.30997-2-9erthalion6@gmail.com>
 <ZXGZaonxi9hLWEIJ@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXGZaonxi9hLWEIJ@krava>

> On Thu, Dec 07, 2023 at 11:07:38AM +0100, Jiri Olsa wrote:
> > +	if (tgt_prog) {
> > +		/* Bookkeeping for managing the prog attachment chain. If it's a
> > +		 * tracing program, bump the level, otherwise carry it on.
> > +		 */
> > +		if (prog->type == BPF_PROG_TYPE_TRACING)
> > +			prog->aux->attach_depth = tgt_prog->aux->attach_depth + 1;
> > +		else
> > +			prog->aux->attach_depth = tgt_prog->aux->attach_depth;
> > +	}
>
> I'm not sure why we need to keep the attach_depth for all program types,
> I might be missing something but could we perhaps just use flag related
> just to tracing programs like in patch below

Originally I was trying to make the change somewhat generic, so that the
same approach could be used e.g. for extensions if needed (say, instead
of preventing extending fentry/fexit). But since we reduce the scope
anyway, I agree we can simply use a boolean flag. It still has to be set
for the target prog if it's fentry/fexit and already attached somewhere,
but otherwise would be similar to your proposal. Let me prepare the new
version.

