Return-Path: <bpf+bounces-20101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F13839579
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 17:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62AB2B2C98B
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E307081AC2;
	Tue, 23 Jan 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="i//HiCk7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ve0mp93k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LA4JVKEw"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B124881206
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028348; cv=none; b=aIehSWUrIJ0hQOqcUFuBJ5OrMFs6DJB41d0IwnZPL6xIk3lilhh6Sk/ukmC7Pj1FJbwi3cy0lSb3HIqzsARyKORxqUX7A5Q7onM384mFbLsYHhY+2GzcpXAmpS3N+SiZsWjE2DJgK5RL/kdxLJHTss1WbYBmjA9Li8xCI1Sfids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028348; c=relaxed/simple;
	bh=lDu9G+Ff1dW60mYYsxwbBoAuFgmg5Ly1VlO6i5Y7QGg=;
	h=To:Cc:Date:Message-ID:MIME-Version:Subject:Content-Type:From; b=JUpHHgBK7i/X1x+nNwnapd9OLKqkf0uPj6GsPcZbJdOnKNCHi5S5dDQA8LmfXENL4DPDuwO8aFM351GlTHSTfzw3tav9Paw6WToMpLb3aSob9V0gkIrgL/fBRh8NOUnlzlt5eI11AnsFCvJerXCO7md1sIQrAj8R/5Uno2exobc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=i//HiCk7; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ve0mp93k reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LA4JVKEw reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A3B89C1654F2
	for <bpf@vger.kernel.org>; Tue, 23 Jan 2024 08:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706028340; bh=lDu9G+Ff1dW60mYYsxwbBoAuFgmg5Ly1VlO6i5Y7QGg=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i//HiCk7wcQl6Br4DqZHlnErwDb+ROcGlykgdscFimZk3fBAQ4clnXJhHyJy7sJf/
	 aFD5X03PDy1sviEPAf3WcymetF+J6iTDD3p6HKbUA+qSrOVw3ys+9Vv+1IQMwfhJOO
	 PK/pG9FNgTjEHmfJLqZXtoT4LeVqYcLLySJdeQ6Y=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 6DAECC14F736;
 Tue, 23 Jan 2024 08:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1706028340; bh=lDu9G+Ff1dW60mYYsxwbBoAuFgmg5Ly1VlO6i5Y7QGg=;
 h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
 List-Post:List-Help:List-Subscribe;
 b=ve0mp93kPZ5eTJrIeUwQVxH5FTmTEPKzueEpxN5+mrXo8YqFDoiFjLex13OP0dEKD
 hMeaZOFAfm8UiP0ywYAwQ3I2VJifeojHj1lMQZBZverJU8WGYN8bfM89JpvA4yoqRx
 BK4kjeu4IefejROxNSmKnNw0b34AJwjPgEt4LyyQ=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id DEF7FC14F736
 for <bpf@ietfa.amsl.com>; Tue, 23 Jan 2024 08:45:39 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.855
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 58FfEVfkxpuw for <bpf@ietfa.amsl.com>;
 Tue, 23 Jan 2024 08:45:36 -0800 (PST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 0FE02C14F711
 for <bpf@ietf.org>; Tue, 23 Jan 2024 08:45:35 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d746856d85so14001485ad.0
 for <bpf@ietf.org>; Tue, 23 Jan 2024 08:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1706028335; x=1706633135; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hJeeRlgxsANlNz0Rt6d8ZvxzmvGfpTKOibTWewiQ6bE=;
 b=LA4JVKEwiVWq1UAzSr+pVCLD+CwFbDNszOLnYB3kVczOmLWvjDxEAqHCWZ4mJFl91l
 VEyBkeEyeyCV0CElWdqG8anuh09JssrP04LIdKKvQGBtHQnUZFP5slrDGQyhnPMVIuND
 UlswgE4fDv6+JZyP3dsR8of9eX3tEygGvF0qd6moPpyUkJHWe4rrwP099oxmeKgP1rww
 yfdu8VZ181tVNgJvf+uHG+mT5/tx+Qp+wrfET3mBthQRLzKEIWfCFc61oTE/XMHoVVJh
 dEmpr/QjSCURY1lxw5m79Aj0+Cf96PzvsrLSmGAQiy7LgLqrICNq+tkcuFTql3dCGAuF
 xzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706028335; x=1706633135;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hJeeRlgxsANlNz0Rt6d8ZvxzmvGfpTKOibTWewiQ6bE=;
 b=tx6OKZ7x4Qe516xGNBTpilUyc11eDmAnAbt9P/Mil6pwtjC+59m4abPloGEV3aWSx+
 cdK6CC54ZAuyauOWCQSlJkGx1MV0oEFaPaBPRsw4175wFUc/EZE0TtyK8YGJ1CnWK0J/
 ZsGBzZ2I9ImRYarFoEgnPdWhIpVmonRzP1IoDlJoiTSTADuZZ3uz4W+OsFLyOk0LBXxc
 ESzQ1rABoSF4n0nRjlCDqmCYfSfZ+Z7neYR/HLCVCUgLQT3Ryx+4zAp4+8MhlD4l4bzU
 0/NIcK/j1tdvgTByMlCAwiceKRSQodyZBgWpVE3o0OtiQMrcAhFkkLI1Xiks4J/sLZAs
 HdAQ==
X-Gm-Message-State: AOJu0Yw8cz4RC0lF4RYKf0j/4CtCNEWMT9KPgE/x/0i1JpN7aPEuLEZV
 lNAo6ZLyb4ONyqLmS/dLb0RtyNgI+C20+ZgfwKxoX7nvQwzEM+2+XYiyDfqOC94=
X-Google-Smtp-Source: AGHT+IH5YOleyWPKHKBftw+0ZioHtNO2oUluCSxlv4Wypt1/y5qBh/9M6rgZ/7N0ez8IC7oUZ9wG4Q==
X-Received: by 2002:a17:902:d2ca:b0:1d7:6e2d:db5d with SMTP id
 n10-20020a170902d2ca00b001d76e2ddb5dmr1038301plc.40.1706028334876; 
 Tue, 23 Jan 2024 08:45:34 -0800 (PST)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 s4-20020a170902988400b001d7180b107fsm7618936plp.228.2024.01.23.08.45.33
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 23 Jan 2024 08:45:34 -0800 (PST)
X-Google-Original-From: <dthaler1968@gmail.com>
To: <bpf@ietf.org>
Cc: <bpf@vger.kernel.org>
Date: Tue, 23 Jan 2024 08:45:32 -0800
Message-ID: <1b5d01da4e1b$95506b50$bff141f0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdpOGXKikUBFay9kQuqigSHEQGpbcw==
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Chk8V9G-i2NTEUahw3HntrRC7N0>
Subject: [Bpf] Standardizing BPF assembly language?
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org

At LSF/MM/BPF 2023, Jose gave a presentation about BPF assembly
language (http://vger.kernel.org/bpfconf2023_material/compiled_bpf.txt).

Jose wrote in that link:
> There are two dialects of BPF assembler in use today:
>
> - A "pseudo-c" dialect (originally "BPF verifier format")
>  : r1 = *(u64 *)(r2 + 0x00f0)
>  : if r1 > 2 goto label
>  : lock *(u32 *)(r2 + 10) += r3
>
> - An "assembler-like" dialect
>  : ldxdw %r1, [%r2 + 0x00f0]
>  : jgt %r1, 2, label
>  : xaddw [%r2 + 2], r3

During Jose's talk, I discovered that uBPF didn't quote match the second
dialect
and submitted a bug report.  By the time the conference was over, uBPF had
been updated to match GCC, so that discussion worked to reduce the number of
variants.

As more instructions get added and supported by more tools and compilers
there's the risk of even more variants unless it's standardized.

Hence I'd recommend that BPF assembly language get documented in some WG
draft.  If folks agree with that premise, the first question is then: which
document?
One possible answer would be the ISA document that specifies the
instructions,
since that would the IANA registry could list the assembly for each
instruction,
and any future documents that add instructions would necessarily need to
specify
the assembly for them, preventing variants from springing up for new
instructions.

A second question would be, which dialect(s) to standardize.  Jose's link
above
argues that the second dialect should be the one standardized (tools are
free to
support multiple dialects for backwards compat if they want).  See the link
for
rationale.

Thoughts?

Dave








-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

