Return-Path: <bpf+bounces-18673-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8769881E707
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 12:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90FB1C21F0A
	for <lists+bpf@lfdr.de>; Tue, 26 Dec 2023 11:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA93C4E1BC;
	Tue, 26 Dec 2023 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IO0IE05L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425A94E1A1
	for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-67f911e9ac4so37230636d6.3
        for <bpf@vger.kernel.org>; Tue, 26 Dec 2023 03:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703588797; x=1704193597; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=P5P85/21DkVDTU0e9tO3V+0IhDVl6xeXMSjQT+g8krI=;
        b=IO0IE05LyQOLlBzNVCloFXA1DJ260ESQL32IJTdNFO5qJSBUrImkX80LhD9nA7Isb7
         6BMAdtO1bLQ6LUBCc/d/6h8bdZSzcTcIzBOEVauJ27g+vTst3AJEWJwyAlgYMzHFwtDP
         y/5oAgwcOoglDQ4djWNoRaluswBdTUfxZXltKVWhI2UIqtuMcKSyP5enH8Z5tkyurtqe
         rsRyIwNcMXAJI/Jx5jUSZNKmEFAaU6wZ6SdTXHxPqJ9LL0mBYv3QiZ6LEKy7lepWGxBy
         TCQNTq8c9wcDGgUt3qDlupgMBzvy3qeMeMT8pvqaanIthto9Lb4np12mAxuVEatYUhjg
         Zfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703588797; x=1704193597;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P5P85/21DkVDTU0e9tO3V+0IhDVl6xeXMSjQT+g8krI=;
        b=IZV/Fd3oy9K+P+RusDEcihJC9UaN2SVal224tqa9J522N3AGD/7shEuutiy95l+3xx
         hiNd4d40ZOw0uFO/CSdFs5Sd8S1Rsg/xzqkrGyEepRSVv90SBM100RCng9Vo6ITYvbzL
         N+Li9Nd6VVnR3doe3Jf+UQbWDaplizcATm808vuaYWU/Gd+GbSYIJrCaJFGkEL3qZ949
         BNhDm78vw2ADs2XrLDrWGpRINhmiXfAfujXKUHSNoq602SA36dcEwoPxBGu9HoV8wtKo
         6m8+/BItdlt1jMS3ET8hlx+JzWEYnMmD9zvmM6AtjnIyC8sQgMDCllHW8O2j/RsbdykT
         mxjQ==
X-Gm-Message-State: AOJu0YyrzIgGPRlc0sp2UmbZlS8hgCWOUGTV4wvC4KZKcYuJm9IrKluX
	dwWsdGkLP23Lh4BUzQ102P26SYp0eX5WyUW31fWpi4uef1Y=
X-Google-Smtp-Source: AGHT+IFnVV9TVWvDIW0JkTlzXSsu59A3Rgd8X2srFZxrz/+XAnyt/4uu5RrEUrY0ZvZdJkjRv7yZxWv7aw8e7l8cGdI=
X-Received: by 2002:ad4:558f:0:b0:67f:aec9:6929 with SMTP id
 f15-20020ad4558f000000b0067faec96929mr6414927qvx.71.1703588796706; Tue, 26
 Dec 2023 03:06:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Rankin <rankincj@gmail.com>
Date: Tue, 26 Dec 2023 11:06:25 +0000
Message-ID: <CAK2bqVJPOE85VqfCEU07sjjE=530D_ac_AgcnFB6GdFKzN85AQ@mail.gmail.com>
Subject: HID-BPF fails to initialise for Linux 6.6.8, claiming -EINVAL
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I have tried to add BPF LSM support to my 6.6.8 kernel, but HID-BPF
fails with this message:

[    3.210054] hid_bpf: error while preloading HID BPF dispatcher: -22

At this point, I can only assume that the Kconfig rules are somehow
incomplete and that there is a missing dependency somewhere.

I have raised this issue as:
https://bugzilla.kernel.org/show_bug.cgi?id=218320, where I have
attached my kernel config. Can anyone see what I might be missing
please?

Thanks,
Chris

