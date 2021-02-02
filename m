Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0D630B594
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 04:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhBBDC5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Feb 2021 22:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhBBDCi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Feb 2021 22:02:38 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DC6C061573
        for <bpf@vger.kernel.org>; Mon,  1 Feb 2021 19:01:57 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id b3so692945wrj.5
        for <bpf@vger.kernel.org>; Mon, 01 Feb 2021 19:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:sender:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=PrILWatQiBB/YexVPvDZsH566iBzGTKnf23zrhwD0wk=;
        b=ZSdt28kd5LFeMD6OV1cwhYMtyUNSP/tUmvGACjI83KcWsklB/t0wrCRNrR8f39p1Am
         UJq7P8xSrw4jh+9iwZWpC1GNBUYmWTUyRarm3uUqsOxpGl488v0BDSFdhlVpHrJh3lm5
         23ezgRbCGNfo99t4BvgtnF/6x2POEVQxmYl2RFU4MEnc4sz06h29HYnFCuXg5tVlCK/u
         3CQdGOjzVDFB25PYSgQVuyvUkZwHu9n9EDYHsbL6Dg7rJIAMmh4hgZX6K/PzDJFB5o50
         uFqzMp0YAboet+4cyWQlxHcfQVqZ6n8paKi84FvOHCkbb21eAZTWou+g79IMbU0eZd0e
         010Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:sender:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=PrILWatQiBB/YexVPvDZsH566iBzGTKnf23zrhwD0wk=;
        b=aa5QRqdGHer6Bc2rRiMh9ImPu/S+QCLFKYuP9vUiRoCWeErpLznfCGXeG2xzqHcczI
         q0BnJfoMhQtItwWM+NIVmH8zL6bB3pBzw3KPla569DJxkHGOy6W8HDVe/nxUh1KTW4W/
         jmhoxjECcnUivy26bG/581NVTgQAnuIs5iG3BIMmE9vzrBgX6VxQI9vEhe+ify4OTSTZ
         Qi59aPDrAJp/gKfHF360TlRrJJOP5mTjLaEQ3lytdN6QAre8/9pxROUnrBOeUqUgf++J
         3XYJi/UHPOH/K0e+35zJOhd3oG0asfiItNeBuDEi+dJQ8Tact5UN/xzdSBO/z8CwuZ/+
         q/jA==
X-Gm-Message-State: AOAM532gKv7MC6yR5IT91CLE1Z7ngwmM5tbP13QGBHzkWvYltCFJAAf+
        lOt4pM30Zq6YmkGzPiJ4TDE=
X-Google-Smtp-Source: ABdhPJw+PXzxWGtSMuQpMd6jRxENjUanV+P3BJAqe6Wc79uH7yj+4TGGIbsbxAJcYT+AtuifMDCIHw==
X-Received: by 2002:a5d:4806:: with SMTP id l6mr21698166wrq.389.1612234916469;
        Mon, 01 Feb 2021 19:01:56 -0800 (PST)
Received: from [192.168.1.8] ([41.83.208.55])
        by smtp.gmail.com with ESMTPSA id h15sm29301756wrt.10.2021.02.01.19.01.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 01 Feb 2021 19:01:55 -0800 (PST)
Message-ID: <6018c0a3.1c69fb81.75e30.847d@mx.google.com>
Sender: Skylar Anderson <papesarakhfall@gmail.com>
From:   Skylar Anderson <sgt.skylaranderson200@gmail.com>
X-Google-Original-From: Skylar Anderson
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: si
To:     Recipients <Skylar@vger.kernel.org>
Date:   Tue, 02 Feb 2021 03:01:49 +0000
Reply-To: sgt.skylaranderson200@gmail.com
X-Mailer: cdcaafe51be8cdb99a1c85906066cad3d0e60e273541515a58395093a7c4e1f0eefb01d7fc4e6278706e9fb8c4dad093c3263345202970888b6b4d817f9e998c032e7d59
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

esto es urgente / can we talk this
