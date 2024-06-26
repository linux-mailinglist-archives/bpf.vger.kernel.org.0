Return-Path: <bpf+bounces-33129-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167699178A7
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 08:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD208288DE7
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 06:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C5014B07E;
	Wed, 26 Jun 2024 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPN1y50K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A9514A4C1
	for <bpf@vger.kernel.org>; Wed, 26 Jun 2024 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719382370; cv=none; b=PzJVnxmSYOc7UapzV3Pq2SPzEzEet5tW2k8RAjJEvp9imvcMomAFTB6u1uWOtc6Zg/L9OH8JwQ6mAVC2wFhPXYQbi2/K0eGtz+jVK+bnhjtJHVBhJNJziPJaTEywoUkcjnvZOnLSXj9CXgDGR6/0SKyqPfGm3OtHLsp7RKYJtso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719382370; c=relaxed/simple;
	bh=8jHS3u9dyijzKPvxSeFE0Z2uM+1lT7vNYXZVcgO8fBk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IxkG1LFQsurM2va0IXPKcHVST2JW7J6Y2x8g2wVrvRTxTPkEUfH3/ANMxPCMNKGrQ7Y6Ga8G+H90bYXHkHKLpPk3IJbrK7jd6FBHXZ0CItg7spF1XGPaG1sQpJoj0NTBv3aInrjrHJjosLrfKJNLpZeEQaVokZihIRGTb7t4LHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPN1y50K; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6327e303739so59475217b3.2
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 23:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719382368; x=1719987168; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8jHS3u9dyijzKPvxSeFE0Z2uM+1lT7vNYXZVcgO8fBk=;
        b=kPN1y50Kvwczl6oWdn9/u8e5dKFVm/QN+yg802+GLou6Ur71KGf4arOAMhVl+lzfb2
         FSc1K2VTUqxftR1n+i4oW7R/IXnQduVzYzS95DgXjLYy+d0b3FgSnLqfYtKchfLOquhW
         BLK0hGXSBiflYZovoYK1XRC9Nmobs+Dmy3N7pwmB/HZXsfXpFtPZTg3m/ddQmHcCsLdf
         cwIZ71oM0SokFS4xforiQwUAzu0c+5Sy+2uEXbmWmrC6+rxdKej4X3GCKA2eW7R75bVC
         NHPAlup9InkIjOZRH13zo7fgyztFAQDD7wRo+9uNAUNDJxnuIMNSAx4HaKtaA2qeDK1M
         TCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719382368; x=1719987168;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8jHS3u9dyijzKPvxSeFE0Z2uM+1lT7vNYXZVcgO8fBk=;
        b=nH+ERMCtbIbQrPl2/LaZIUqRDs9pSLxJx3xsGzqYCf1DzU6mRoj9bKezsr95TgzlAW
         L/1YGHt+1ekWs8w3ezo2yBpOWO5fnDgIjbuMygpmsU68tMMPtONsbIXweKM6HMyeuFuk
         IgPiEAbI7+7l8uzbFaIOxFbmYcaNYrGWCSrO1zyg7uzRopbm6ZlS5y//s2ym3G8DycB/
         YQFVDW/yGqccXgf5Hp2SylktEWLKp01monoIBOcI9EQv6QzoiV69dJ1+eHPIi0QC7DSu
         3YQIdMnXxq5Odm3138iLjvF64SNV63+uKwKan4o5nf0KeAbC+qbdHAzDKYONYh5AGW7f
         URVw==
X-Gm-Message-State: AOJu0Yx1wx7BN9TkREPPN+DwnAuqwCDGoRIogTlUQl0Auy7/isXaouyR
	T68B8qCXmGSRAOFloulZsoBnT/GDjVq5iJpJ6mjDQNHV8PNvZME/iO2u2lKQENrvkd1xjI04ncT
	AwEMcnhe8EeD2d+3CVdxZt5DvlqZGjCrtiXow0X+H
X-Google-Smtp-Source: AGHT+IE6nswrpmOeU2NhCDctL48H3r/FfP7BoRpfRX/Uh95OyVr7WNdtJ3SFXqZWrbByqZH8vcRfdqYzw1agiPJZXLk=
X-Received: by 2002:a81:838d:0:b0:62f:635b:284e with SMTP id
 00721157ae682-643a69626d4mr82417847b3.0.1719382368059; Tue, 25 Jun 2024
 23:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Totoro W <tw19881113@gmail.com>
Date: Wed, 26 Jun 2024 14:11:18 +0800
Message-ID: <CAFrM9zuz8Wh5g7ykOkmFXwVdxgB7NQWzDbvv7=CEpEks54GnSg@mail.gmail.com>
Subject: 
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks,

This is my first time to ask questions in this mailing list. I'm the
author of https://github.com/tw4452852/zbpf which is a framework to
write BPF programs with Zig toolchain.
During the development, as the BTF is totally generated by the Zig
toolchain, some naming conventions will make the BTF verifier refuse
to load.
Right now I have to patch the libbpf to do some fixup before loading
into the kernel
(https://github.com/tw4452852/libbpf_zig/blob/main/0001-temporary-WA-for-invalid-BTF-info-generated-by-Zig.patch).
Even though this just work-around the issue, I'm still curious about
the current naming sanitation, I want to know some background about
it.
If possible, could we relax this to accept more languages (like Zig)
to write BPF programs? Thanks in advance.

Regards.

