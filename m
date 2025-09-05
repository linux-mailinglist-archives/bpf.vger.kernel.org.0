Return-Path: <bpf+bounces-67538-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7DDB45177
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 10:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B651016CF19
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 08:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2483112C3;
	Fri,  5 Sep 2025 08:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GxqU0wHn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037793112C2
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 08:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060961; cv=none; b=sPzklzK+Z4W0gIi0B4+0Mt6lmo4NVFwNXd+OVTqRDync+9Yc8z3HEKIXNPLDBzyD+rVoLjzfaiz52WHNt4LfmyWzAz5QaFerTlULm4wYqTa30SN+L1TunKkglXmS9/eDwWJyf89+6couRQcjhVR89hPbE7AidePmR2BKRaW5Uaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060961; c=relaxed/simple;
	bh=kwtRzEimvtpLrmOqqyXZ2f1tX9zUnglfb92WvRi+wAc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H66zVOPKZczCJAzBDrMo3f4nrJrGsNAZl3cC01h85DYcAgB2qYL2wWJX/QmE+0S64J0WZTxkwNeauIDquROXzm56CPzUUUOResNgtV2oJOIAXMCQnyRkc5WKQ6W2pY8gDwD1xxvh7R2JVNe7DGVfGxDB57jEHUCtlgnjSDNfDPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GxqU0wHn; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3dcce361897so1277607f8f.3
        for <bpf@vger.kernel.org>; Fri, 05 Sep 2025 01:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757060958; x=1757665758; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AjrpyuHiQ2iH5gQyFoJsWbyIGpc1VmBeELccX5MB0vw=;
        b=GxqU0wHnPbimGnQMJydFp9h6gRu+1fM/didYq1YsDD96ZNHK1tjOF15VNtlJmDn5Fa
         FFUvA1YwRjbDNi+wACdQhRBrOyoRMAJEmWK25CA6P88qrYUALoNbrIfHZJ6lJCxSTi9Y
         9yioZHy7uM3rpybbvtMQvsF3YNzA7KrhiePIJyJdkCv/2fA/UBl/oirI3jX+BRS0gbnA
         JSOyuJ5Ww58FfBwBF82qHuBb/twVgCFK3KYs2COTOztUBQpo3ktNKde+iVLSxwQ69JJI
         /4CKwGD6zsV0tzX+3VYft2qXLxNVht9ZF1fNEfgp3Y+dJ/bCDjUYQrvtIfnhx5wekKNh
         Ah/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757060958; x=1757665758;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjrpyuHiQ2iH5gQyFoJsWbyIGpc1VmBeELccX5MB0vw=;
        b=ECNKfysJkNvOIMpik1ruuzV82dSBHnlGpS+XgrMVz0tFzPkgwkTr4y9c27D4JADjez
         ZfwOT71YS3ln1dAQNpgh/1HP8fZ2/MqMZ8BUsWrQL2jlkxd2j3+W1devT5mmwqJVstnS
         NnwxBypfRE6OAjdNOG2dGy2kcN1AuAWqoN7ydcCinUpPWjVpQ+bUOKP+GlgHHqfxFcKF
         cf+jTr4l2HjIngfaEBq7NLH91wBW+dNZ/S16y1U/VpxCjYb4Vlt31I2EnZa3oRALqA9z
         wNY3KiXABxk86Ltm0YmR3as2MWJpogDxP1iJIzTOeJcFNVvcVTInpmRN0sWPiZIku56J
         kWkw==
X-Gm-Message-State: AOJu0YxYdoMbXeTYbH/IVsvIzX6DgxAIvcIaNaXVpJKxVTVlqgOj0w6r
	lfmH9wg7rNa4sUvENGFPntz8hBZV9KeTcAHnYEQdGQfzRAtejdM3eWKnmV/bXdGS4OU=
X-Gm-Gg: ASbGncvopA5A4HRPPuxRT7tyEeLDnA1IVZnL1nus2HOLblbxq3FE6sknNrbPR/azzlD
	q640OsLBwuoizOtoNdtECWajxsiXMMw0BhuC8NPmjuBHASXi9MXjECtgFU65wEe0kzf4FheV1Hw
	f1SjRzA96pqYB6dnS+8HNvr7d92pkiPVeKHW3e3nJMBh0vlh6VvBiiRojd2Xz0xT/mbkx5ov07B
	F4nDB3ZOIF9Vau9QraKjX4QWYswIDJV0s3nhcd5aO64jcrfi0O6pmOQsdGPY/FgewnMg6WNewMi
	6ir+kwsDxuCIxLQ4HH92Rdzfh99webLGWE71xW0NkH+G3w11skrzD/hW33wg4e3TJRVqK15VQhG
	um/HU0tfOnis2gzwBiCkvQH1cUwqOWiOgqqe1mQ==
X-Google-Smtp-Source: AGHT+IFEvCT7cftOHZO5jf4iWcOS3253s9HffuDuqj0+9u9GDfbc5U393v8kkgducPBi6qjGPaKlww==
X-Received: by 2002:a05:6000:22ca:b0:3ce:f0a5:d594 with SMTP id ffacd0b85a97d-3d1dca7bc64mr20100856f8f.13.1757060958381;
        Fri, 05 Sep 2025 01:29:18 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45dcfcba94esm37384985e9.2.2025.09.05.01.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:29:18 -0700 (PDT)
Date: Fri, 5 Sep 2025 11:29:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [bug report] selftest/bpf/benchs: Add benchmark for sockmap usage
Message-ID: <aLqfWuRR9R_KTe5e@stanley.mountain>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jiayuan Chen,

Commit 7b2fa44de5e7 ("selftest/bpf/benchs: Add benchmark for sockmap
usage") from Apr 7, 2025 (linux-next), leads to the following Smatch
static checker warning:

    tools/testing/selftests/bpf/benchs/bench_sockmap.c:129 bench_sockmap_prog_destroy()
    error: buffer overflow 'ctx.fds' 5 <= 19

tools/testing/selftests/bpf/benchs/bench_sockmap.c
    123 static void bench_sockmap_prog_destroy(void)
    124 {
    125         int i;
    126 
    127         for (i = 0; i < sizeof(ctx.fds); i++) {
                                ^^^^^^^^^^^^^^^
This should be ARRAY_SIZE(ctx.fds) otherwise it's a buffer overflow.

    128                 if (ctx.fds[0] > 0)
                            ^^^^^^^^^^
Instead of .fds[0] it should be .fds[i], right?

--> 129                         close(ctx.fds[i]);
    130         }
    131 
    132         bench_sockmap_prog__destroy(ctx.skel);
    133 }

regards,
dan carpenter

