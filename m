Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9114598B4
	for <lists+bpf@lfdr.de>; Tue, 23 Nov 2021 00:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhKWAAo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Nov 2021 19:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhKWAAo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Nov 2021 19:00:44 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA88C061574
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 15:57:36 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id o14so15488530plg.5
        for <bpf@vger.kernel.org>; Mon, 22 Nov 2021 15:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Ksbk46j3gCZRpCwu2U8xWAZQC3JFbcufYmyhWD/6Bo=;
        b=YimKbAndvWDg20U293fp0unUB9K8BCt3CapJotGuCi0QcFEfjJks0oXfuIF665Hyns
         J+SPDRmeXhX7zvTLFUWZodtDM0nauzNkGzQIU8HHGtSEfgHtY0YJxJ6UalrfZPADAeiJ
         OJ5P2Spw5N74Vb39tnrlJ441r+7xvgRQ5qZIPe4bxpKSeBiKAeqt225sIt4wEER2u3qK
         OkZYWcpe+c8CvD7wSrbxzXrHSVoTgS5v925pCbvM6krYfsSYPoFG6f6qVtEi5CtdSbPu
         YpCeDDkLqSWClQQmskU+H17d0GezbdtO8yvLWfMVUKclszuQVo1idc5FdDKBHEnCj206
         e06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0Ksbk46j3gCZRpCwu2U8xWAZQC3JFbcufYmyhWD/6Bo=;
        b=EQ34cZ4sADANp0nD9PHQUytOLPxWTaphbVC2oPZEa/nOzvEzPUkaepGFAf//TqhhwP
         mALPNn7PwzSxpJVaG5txpX6vQBym0/kf4PdpZhI8d5ayAssRctYtPkabBI4DDJ41RaGr
         KSyzWkip7InBB6KLrVnMnxlRbrWh3qjI4Sy0GREYV9+kfQIwEWQS8O8Xx8+UOHuRZpWg
         yUgzZMmCV+gk2eFfv/SJo3rxtL4Hhflh9OVPM1/lwNom+ApZ8MkDZHXXtTskT00aH6GM
         YA+dwnAg38buaf6OZ/fKkeXBz1j9jLBwXSSlMIVgiU0gAImzdc0hlUQtEg2jCwVrWIus
         C4gw==
X-Gm-Message-State: AOAM530g9gOfhqNw2zPBiyEfuUVjjuynjkaRoCwtC9kgrAPtw7O1Dh/Y
        WzmH84rH9aW2PCK/okVxZoixvW0C1yQ=
X-Google-Smtp-Source: ABdhPJw3XLlCmeSay0B+fxWBFhEJiWuVJSnZwXfqClHwXHlOvoL3tZAM1PG2Nxsm3ApW6/DlYrpxuA==
X-Received: by 2002:a17:90a:c58d:: with SMTP id l13mr972182pjt.189.1637625456140;
        Mon, 22 Nov 2021 15:57:36 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id o185sm9559844pfg.113.2021.11.22.15.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 15:57:35 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v1 0/3] Apply suggestions for typeless/weak ksym series
Date:   Tue, 23 Nov 2021 05:27:30 +0530
Message-Id: <20211122235733.634914-1-memxor@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=594; h=from:subject; bh=/xp4Hf3A4g8NQ0wXdqG0y9ucxuphNhQCGhzF0aV9jFs=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhnC22YeSmQjGcl12GFap9FTZJjXlo6VyOPwd95yTW 0tTb+HSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYZwttgAKCRBM4MiGSL8RyhhND/ 9bBMYIxWouAv0hgoeWi4CjzvAzcVHrpFLMJgPe8RkYohZjss2mo2703PFC4oHIK93tGEw5GFF0CrC6 kwEXUrJ3Brr3b+iJdO4tt6jw34sBN2h8zoA/5Mhh2dH0dl8UqFIkkkwNZ1prUq8q7xASQjA3n5kft/ BGPAzl/Dgz6zr0JemG/x55INWzieQsK835kgRg/AKNRdGCQ15ZWKau2/CmiRKGfIoFeNxKd5Xc0M+J t178mhPTV1jYg2fH1jbvUREDD+J0r16pziYo1vi6eWyQpPGKFXo0s7JSlGbqZwX47uYRulK3/6X5sO HeWEVUDHsG43vp8Y5c40O57fmsScjLtuagdTSC4+tfM3dil53SVWJd1xe70n87hpW4dVMiAv5KQobk WdkDKz7hHO2gQ7lrEcCQQDE5eJqd2DtiFsfvIHVsie/fAKgVndV4im1TjxfowwuoJtfiu6jGrg+KCa FhHRFOx7bJ6g5z7jZ2FRQwd/WSwvrnYm40vAn54zS+xsyxNtKdzOhJW2NweXhKGv+IFvhRs2HlJxS8 yuhU0OzYV+UKMM1pp80d+iW7mwnAdxgiKI/6lnHq/OO3yth2msq347p89sgpAPIF0uH8OtBQdsaC1h wZ7/9XEjoW0pna5anpzof+rGzNI7SZHMzeyLYYFiLV4gm/lwNk64zjSGMlNA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Three commits addressing comments for the typeless/weak ksym set. No functional
change intended. Hopefully this is simpler to read for kfunc as well.

Kumar Kartikeya Dwivedi (3):
  bpf: Change bpf_kallsyms_lookup_name size type to
    ARG_CONST_SIZE_OR_ZERO
  libbpf: Avoid double stores for success/failure case of ksym
    relocations
  libbpf: Avoid reload of imm for weak, unresolved, repeating ksym

 kernel/bpf/syscall.c       |  2 +-
 tools/lib/bpf/gen_loader.c | 42 +++++++++++++++++++++-----------------
 2 files changed, 24 insertions(+), 20 deletions(-)

-- 
2.34.0

