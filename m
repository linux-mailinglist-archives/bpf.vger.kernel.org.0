Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDCCB2EF2F
	for <lists+bpf@lfdr.de>; Thu, 30 May 2019 05:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbfE3Dxc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 May 2019 23:53:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34226 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730214AbfE3Dx3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 May 2019 23:53:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id w7so1967875plz.1;
        Wed, 29 May 2019 20:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=PVfUudKZSSRsgWLDDlu5rIq5+aEI9z+7kir93gGSu98=;
        b=tPv1I7AiMzaxAGH4/ZoChIkGQ3P2y1P/f01B88UfmUpt5K4YIFhOL/2QXthU21+tjP
         cJT1BX2t2CxeGhzfwtQv2i58rjBM3dbgtdfWH10Zw8wlVMOV1REPIelee09FG4UfU4Pd
         aNtAShasXOBXpsArZArkGPuakpdvt2bHU83plT3kdJh6/euluuYf5vraJ6167kodvBUt
         34gpl3HAPza+zE1Wn0wabvnqYsIDwLWTu8Zoh9EJAaWLoaYvrdJbq1oXXJmWU6Urb5Vl
         sWcLuvS3sf+GLl/ZbqnVvoyiR6ANXlhn6wVtjd2v5B2qFXzJBZYtJpOHtS2PpAvVaAPM
         ZSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=PVfUudKZSSRsgWLDDlu5rIq5+aEI9z+7kir93gGSu98=;
        b=NJ1U7z2mbbmYsOUIpFem3bXXJ0EQnDORjKIl/ZsV6dxkBqVgBjvJWyqtNx3iIXu70N
         e0nYZtnye6xzJ02+Ltp5fiK1JAq87EyGL2Sn01ENgE+502egTPnraJILJs6z8SMT6Csw
         rgyd85lCQMXPAXneCQ5YR1dJQkNWhD9OqzxJ+W2Q3k9psbZHKSlWNNpcNMJMeoeylmhW
         PAoNmTobJmwzTpWODiuwdcB9Fr7J1PlxE6SoXD+c1FcurPdTlml36ciH065Uol0kp1Ry
         UPaXn8rgD4qesGMSli0TESVN3SRsmvFDaK7fU1nplY0ZCqDfjQb4L9NeRf06lyXNM4tw
         J3JQ==
X-Gm-Message-State: APjAAAW1U8+Tu+ROwy6hEH0d2DvM490SMf26eMC2ggr28fzwe+YLH7ij
        Cg8XwrDYQPgfON6qcvf6xZc=
X-Google-Smtp-Source: APXvYqwDN5x7+LKfvN4qyptzzHadmPubjlm09Mj0UgbtZAc95XvDBB8w+2Kwu03lAHVtqh5lm2OCAA==
X-Received: by 2002:a17:902:b204:: with SMTP id t4mr1747622plr.285.1559188408845;
        Wed, 29 May 2019 20:53:28 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id m2sm745431pgq.48.2019.05.29.20.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 20:53:28 -0700 (PDT)
Date:   Thu, 30 May 2019 11:53:10 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     paul@paul-moore.com, tony.luck@intel.com, sds@tycho.nsa.gov,
        eparis@parisplace.org
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH] hooks: fix a missing-check bug in selinux_sb_eat_lsm_opts()
Message-ID: <20190530035310.GA9127@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In selinux_sb_eat_lsm_opts(), 'arg' is allocated by kmemdup_nul(). It
returns NULL when fails. So 'arg' should be checked.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3ec702c..5a9e959 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2635,6 +2635,8 @@ static int selinux_sb_eat_lsm_opts(char *options, void **mnt_opts)
 						*q++ = c;
 				}
 				arg = kmemdup_nul(arg, q - arg, GFP_KERNEL);
+				if (!arg)
+					return 0;
 			}
 			rc = selinux_add_opt(token, arg, mnt_opts);
 			if (unlikely(rc)) {
