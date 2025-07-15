Return-Path: <bpf+bounces-63290-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C6BB04DD9
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 04:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73B423AFF4D
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 02:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF70252903;
	Tue, 15 Jul 2025 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTqIVgmn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAC12E3703
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752546723; cv=none; b=VvUKqWvD2FS32piDA3cHhdG8SkTziDwTZRDkOo+0feLWddJmYHhbyhnusLAaqsYpwmlSeLcbcerVR7nYp2DxiU+KAqJ49MddUnRKO+lsbExBvf0mrIqSgUYRZ7FuT15haRYylRA/keWbxFl7YXKhc+MCn9IJZsxf4ZfxjzDsKUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752546723; c=relaxed/simple;
	bh=fR0qlZELmBxZw7OqKeaV3oWdRzzSwIw7kAKzZvw6HfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p8KOmSAv36j9fazebsaUfVXpw3t8k3Odsqqz0hx2+Vlv/Lqp2br7tipDTYGMqgetLLSBQJfdGk6xbkUu3IL/Y8+PFx6TNUa1MINgDzZ0F7JSFfzE8a7ncnQ/UgneKS2BbY9Gv5BVmhHwmJxq+s0/wyqHhgJO6se0G7nMYydx2Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTqIVgmn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a6f2c6715fso3922428f8f.1
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 19:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752546720; x=1753151520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fR0qlZELmBxZw7OqKeaV3oWdRzzSwIw7kAKzZvw6HfI=;
        b=iTqIVgmn8Gs9oxzqqzaCVPTBjhve01H/enxyDER+ZtogerGJ/3z7gWYVqqjb4E2jQT
         Y76HBFCIPv6DNcAg8KqeESXDVoYOhCerZIp6RZ6wXwzcdVGRlNrwlmgHDtpPY4xBzTEd
         YacC3VNs94ubmKPO70KheoulQgjh1hKmY36JnPxaN1ucwrnUEboqmW34RFJfhT7rcNbg
         EekygLLaS8vhRmO5o9wYiezryTL7bG9gAP+XLIpmd59MwoYumjkPyH3jAFMmC8nrFXwZ
         NLxvt/s0cWnbuih4V958Waed9kyrf2eOiu/WNUUwoVTfabiGG1uY8lfpGxekT7dcqSpo
         LPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752546720; x=1753151520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fR0qlZELmBxZw7OqKeaV3oWdRzzSwIw7kAKzZvw6HfI=;
        b=QAg3fhA63jOp1lVE5+9ML8ryfYIx0FZ2sH/c+iVNMTAGLHvAt5OUnezBv914IpOOBw
         iePc+GPcMOMhiyUwEE3ZTcNnkesIgHknXmirD/PO7i2s1ZMt1xNFd2Rn5Xk4eWUwLK1u
         H8lS9vhdHqW5GuKhU5fc1hqV3e844r781FoXWlNfgKEpuA8P75dgU5vXEhKqQllfmah2
         lEouVcRUjiYp2qZ0TXZJWA5ZqmsZzHxiBKtTGccSDOvXp7gNUOAh1D/UyAUvdV+fb4xw
         WVNV7lhApoQqVazGoh/gX1A4qrmCb/JBs5ipV2GQwSd6KNtLM2l5VPzVeO+K1SlcOiyV
         mYMw==
X-Forwarded-Encrypted: i=1; AJvYcCU9BYq5OatfdCTWnSOf38NBLN/RBbhH5sNKvMadPGTwtoZ5xR4hXNe2jpLqmhR3eBRmpZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVTut8O6i3YXqsnBDmp2zzmnLEbRjLNN+Nhl43A0iU7IbHP/Qr
	QX/mt/lJKYHlTNGjxds/k31kErMj7FFrlUSu7IUEQHqVFstfTzXXcWssRJoMg1z9ZeHSkRRUBQ+
	IQpD5kdErkSUZxmkmINpolc4unwqKIfk=
X-Gm-Gg: ASbGncvjEhR9n661/hA3L5uX7weexngdqAjC8Tmt/4KduYM8o8fvLqyRQurMukE77Hr
	MGwFHu6n/Dw7Pb+9BGOiaF22ZrCWttN+RFEqrxBGGAieQya2uCS6ioA4GfFDIOrx4iWanWAuNau
	l6r9xib0TKhRfx1A0Bkc/Vx8jcvXwzF48cTkA6ltpGbFf1R1Mty7oUccC+MtyK/2jUc8sGWFnIP
	PzROj1QpJePym8ffr+lKxyjfnuxVdme0xLq
X-Google-Smtp-Source: AGHT+IGD6OThceXqFkDBNZLfFYtzRdVV3q1zejLeHm6kL4mUFLANwMjxbNoX67cQpNCtzdzIdnyjXyvZaKc54uxDq58=
X-Received: by 2002:a05:6000:2890:b0:3a5:27ba:47c7 with SMTP id
 ffacd0b85a97d-3b5f2e2816amr12562371f8f.48.1752546720406; Mon, 14 Jul 2025
 19:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
In-Reply-To: <20250703121521.1874196-1-dongml2@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 14 Jul 2025 19:31:49 -0700
X-Gm-Features: Ac12FXyv2Sh-8B6Bvi4MuREzI2OuhoI3Azzoo2AunWj_Ap1KCI1_s_WPTEtBEW8
Message-ID: <CAADnVQKWjvmM2sGbnVEbbwe7nRiN6omjnjP593vdJjGsqYzL1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/18] bpf: tracing multi-link support
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 5:17=E2=80=AFAM Menglong Dong <menglong8.dong@gmail.=
com> wrote:
>
> Besides the performance, we also need to make the global trampoline
> collaborate with bpf trampoline. For now, FENTRY_MULTI will be attached
> to the target who already have FENTRY on it, and -EEXIST will be returned=
.
> So we need another series to make them work together.

This needs to be thought through from the beginning.
Without it the feature is way too limiting.
People have fentry attached 24/7. It's not merely tracing use case.
fentry-multi has to be able to co-exist.

