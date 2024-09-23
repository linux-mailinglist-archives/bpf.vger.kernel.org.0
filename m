Return-Path: <bpf+bounces-40184-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C615B97E595
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 07:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD461F216BD
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 05:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE42B10A3E;
	Mon, 23 Sep 2024 05:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/3r++xb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46EA28EB
	for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727068715; cv=none; b=kE7h8XseEsEjNyFI6SfXbIZcs6m/xsCU60E5tmiw2u9QzLgLFoyCJAGbJzN+ReCEf6nbPZXei9u17uJnx6VWEN2NQb+fwta8YLO7UaP5ZwxhcLiiYEQPJTHTR18aVtGrHIVeSAduJlR4Ws+Fgn/ZdXMfJUpnJHDN1mmqplB/qUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727068715; c=relaxed/simple;
	bh=5bMkshgwQ12sc6iApaPtZxTRIHDJdxcUDlrXI6RLf6k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=uaB8LC0F6Lq3PxAkOgxQ38YBJtzLxKuAZS4uSoA5KmkCNNZriXLaEyigqmatUiD5ON4TijyQ51kCTf8GLwnSb55tOEd9ra1qABa55Vu7+y/m2iRhN02OJpYdyNuXZPTDA4jj2xZmyYvTt6/FbMg/GieWoS+/C4W8meLoOxSSsIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/3r++xb; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374c7d14191so2982793f8f.0
        for <bpf@vger.kernel.org>; Sun, 22 Sep 2024 22:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727068711; x=1727673511; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5bMkshgwQ12sc6iApaPtZxTRIHDJdxcUDlrXI6RLf6k=;
        b=P/3r++xbf5Pp5sGiRD9SfWpFRwGSUGmCBgkqFtzCNISMEMizJK63KnSDjMjaXt8jak
         IXmBKrJjnO2NqfI1b7CuvuBpgcWgBe+SoCK7BxesP8XOucFa9KX4GyuN6qYQ8rDAOqCb
         py3Xjwnd+ytrMsLl6vKYMrE1V6Jqvos0QU98Z4+qfN0kL7ZmjZriBAxL6AcA9FmrYaz1
         xmzbvRJvX4ZoY0ttc5xiiQWuF5kNHzWAyysxyPwtMmk/Z3fYNecjkfXyYVLM7VtE9uNE
         WkXW6PCCr39EqqRfsyok+XTwaV+/croniTlKV5UkzPfL34zUwjNtjF388+j5vif1/tv5
         41Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727068711; x=1727673511;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5bMkshgwQ12sc6iApaPtZxTRIHDJdxcUDlrXI6RLf6k=;
        b=pjNqd3EX/SaO+M5iaOKIGcCMVmg6CQ047HmLAlNw3ggu9UPhNKVbZRhNxDo+66HJ7D
         baZprJs5OyiGB3NfIhsY++COA/wpqvpuMCODNs6FyFKnN9+8wnKzc6kd3r5NgrI/M4q5
         vZH1uZxw762/IIGfOtThbIGMCOLlVJNWUjSYD7flpOub9Dm6kAOxrk4hbpAT8gepaB1a
         WreqjOJYT8T1nyGwF8YMuoV4YNSQ9PWxUGWu5xGhl4ZjIMIND1E9Rp1hOjscY8fffzg1
         1l5c+Vdz0Dze2TQmm9sZzKPYoMratEBNWgMZq3Rh/6DtYrZxIdHH3h6UT4SdHrkU3Ff3
         KO2Q==
X-Gm-Message-State: AOJu0Yx4EHa2CVQjMl6sXoycjO4vrpOIZrSRyGVDSiwJFff2P8P3JggB
	ygJbQevWRPfRE8y9fBOQn9uBtyoe02ndWwaMK3qM2GTtKSKZDCuc8Dd8pOjWxtrpXvhGUhrUuLA
	8Ro8XyuSofkTrAiP98n0JyJqsUjeWqT4Z
X-Google-Smtp-Source: AGHT+IFUcTOm+N6soDzctNAF5xSQFE5be8W2Br8U3hszhs/VTPBfwHdhcxkMU2+S7ybSn9CtHKVnEK+EmTDcnoDwCIg=
X-Received: by 2002:a5d:4f05:0:b0:374:d006:ffae with SMTP id
 ffacd0b85a97d-37a41497226mr6466965f8f.6.1727068711257; Sun, 22 Sep 2024
 22:18:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Abhik Sen <abhikisraina@gmail.com>
Date: Mon, 23 Sep 2024 10:48:19 +0530
Message-ID: <CA+KXx0WsH1en-DNXLf4mc4bC7apK_U9js0KbFSfp8Jdm8K8W9w@mail.gmail.com>
Subject: QUERY: Regarding bpf link cleanup for invalid binary path
To: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Team!

We were looking into the bpf-link and bpf-program-attach-uprobe-opts
implementation and wanted to know if a bpf-link on a binary path
resulted out of bpf-program-attach-uprobe-opts([a binary path]),
remains valid and leaks memory post the binary path getting invalid
(say due to the file getting deleted or path does not exist anymore).

Does calling bpf-link-destroy on that link give any additional safety
w.r.t the invalid binary path, or is it not needed to invoke and the
internal implementation of the bpf-link takes care of the essential
cleanup?

Thanks,
Abhik

