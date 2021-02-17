Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6DF31D7F0
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 12:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbhBQLJZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 06:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbhBQLIz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 06:08:55 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD5BC061574
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 03:08:15 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id n1so9699912qvi.4
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 03:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=1modw9BZNdPfxYUaaJFvkvekSj+kTyCztdooD0nRWUs=;
        b=LhHCcqPhzj/XJuJcrhRF46TXfvRJVjP3CfjE4hJ4cxSDnDGvAFLSs7y37tqEQwDbHK
         j6UfzwpDHbUxatHGykjkAHuABcIdyHk1uYIQ+0YzDz64oj6HW7c8lW2mCKhZ7FIInMHo
         o7uC/n6tZOSR26L9vuHw+/Ry29Tk1MnIa8KAY2yJRar4XplcATe7gD0sviZlXT5FkBkj
         EbaemgSDD/Jtq0WJISpDD0zEKVADZFgPigPw3gkrXfiAhXiVxt5ywYSD2lqqfJGxljqX
         TfRnBJMEagbt0L5S5R65A3pSFrsQ93/SriNqKacEzS8J4hn0aXsq+mzQnycy0FWn572R
         A1Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1modw9BZNdPfxYUaaJFvkvekSj+kTyCztdooD0nRWUs=;
        b=YWstSsKpFFy4ZuUfdBZpsHseZHZxxmgykJziQTIcNcsZNTXDsw+FKfgIclHh+1qp9+
         9DY1C7QtwdaMKbntrqmbZBm9SEMZg23VTnI7o3stMbFW+lyGlPVVYqmBvh+HZaC8ZgHH
         aV83RyIDz+0RATGo4y4K8P0Zk3fi1oCYk9XgKvBh1JBLbtTdTF1GsEueONXP0rTJhybK
         aRqB2K4aoAiMY9NhhXN/U1HCwNptjbkGSuaG8sRTNuIh6LhPrvqK1rL9B5Tjj2FvtYa3
         gyv/SJYPAeMfqRb3uAJ8Yc6544M12Hot3+tcraeBLlYvB4r06UsTbR0ItEchkj5n98Rs
         CoYg==
X-Gm-Message-State: AOAM533/S1P1gSKYKGSzb/KlMTww8JQFckCI+Ug9VBFjP+o5bgUiYD+p
        hYOgeHcBriu2GAc940QxBlg7iw4cQjEV3g==
X-Google-Smtp-Source: ABdhPJxA3OhdA1qH/n1P6vTxIlXqgmv6/w8dYFqzqt9OgedI/MaB2h1mUGi7CP5/HVnhywNSOYJcw+YNAUrUXg==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:61b3:1cb2:c180:c3f])
 (user=gprocida job=sendgmr) by 2002:ad4:4ba7:: with SMTP id
 i7mr1958624qvw.34.1613560094469; Wed, 17 Feb 2021 03:08:14 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:07:59 +0000
In-Reply-To: <20210205134221.2953163-1-gprocida@google.com>
Message-Id: <20210217110804.75923-1-gprocida@google.com>
Mime-Version: 1.0
References: <20210205134221.2953163-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v4 0/5] ELF writing changes
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org, acme@kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, gprocida@google.com,
        maennich@google.com, kernel-team@android.com, kernel-team@fb.com,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Arnaldo.

Versus v3 I've addressed Andrii's review comments, but some there may
be some style consistency issues remaining.

The first three changes are intended to improve code maintenance.
The fourth remoevs the llvm-objcopy dependency.
THe fifth aligns the .BTF section.

Giuliano.

Giuliano Procida (5):
  btf_encoder: Funnel ELF error reporting through a macro
  btf_encoder: Do not use both structs and pointers for the same data
  btf_encoder: Traverse sections using a for-loop
  btf_encoder: Add .BTF section using libelf
  btf_encoder: Align .BTF section to 8 bytes

 libbtf.c | 183 ++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 114 insertions(+), 69 deletions(-)

-- 
2.30.0.478.g8a0d178c01-goog

