Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B68387B10
	for <lists+bpf@lfdr.de>; Tue, 18 May 2021 16:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhEROZU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 May 2021 10:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhEROZT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 May 2021 10:25:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404E6C061573
        for <bpf@vger.kernel.org>; Tue, 18 May 2021 07:24:01 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f75-20020a1c1f4e0000b0290171001e7329so1579131wmf.1
        for <bpf@vger.kernel.org>; Tue, 18 May 2021 07:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJqE9RhCy0mG4vaM02HEpl8LbQUwkRLcnKek48OaF9w=;
        b=qslFwKHm5geSoor9GhwKOczwbQFr/q0xMVBUaZNGVLOZlPgJlwIiR8V6gDnt/g58Bz
         EjSbGRev8mgIJzaF8wD2LtzAvngGlTNSYIPjZkNV2mznWhNuO2R+V25nAsWFuhf34u/X
         +Pc1pkWUAnO5PTZLcRGXqr6BvGnvlv0H4K2DIp0p0twjQMGAoN1DBmp9Vvv4QuhMpq89
         w6hyjcr2WieCfCF/UaVs25DtJLLUDMC3PXbXk1lrOQbCm/+2fnQchiCF+J3vcSUr7sK1
         Iug+7Q+1aMqPwFjnwh3rCiywiTKMy7IToHSxOwtG5gAulMX7pf1RJk6vq6mD9cwTcaF5
         WApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJqE9RhCy0mG4vaM02HEpl8LbQUwkRLcnKek48OaF9w=;
        b=A+J1lJgqfkqbB9oHvYNypkCM75fmpuZ0jdF3djOqcV+ykz8Y+M7wGllfvgX6vvDrvD
         tjITY34Y7fRBEuSzhK+VOUchL98vdYwrqRPvMjeo3fttO8hR9BRKIWThZFmvNhA2lZw6
         q7WVdVjj4TqIfhm1yXe9763HuJxdpMNnF/WIK6jyjXVxfbdoxphcvQEtFhFW7Mh7Vmjz
         rwEI1SE7scVMPhGeBnpexM2Og8JUBBScT97yFPNDNLzknMqmugVTfIGw9u/sj+DxlG/f
         yxFlUqQFR4Ep9C2vHIRRgrGRLf/S7SFp7rPs8+tAwC+ieyCK5AOzQ37y6kOoBhkG9LRh
         Bk6w==
X-Gm-Message-State: AOAM5335/qhGDuFNB/nd1rGVjSoGUXZ6gA4Jc1H1aqTHxWO6J7R/b7ct
        SISqqJb4xjs4vwEmsYs8FgbeYA6nigH8
X-Google-Smtp-Source: ABdhPJyyPPHxOGnTDoutSKr9jZut0aiYLXjdTh/RBqHEBUKxgE5T6K1+15LsmzJZp1SOgfDBj8QgQQ==
X-Received: by 2002:a7b:c20e:: with SMTP id x14mr5322076wmi.117.1621347839457;
        Tue, 18 May 2021 07:23:59 -0700 (PDT)
Received: from balnab.. ([37.17.237.224])
        by smtp.gmail.com with ESMTPSA id u126sm3443332wmb.9.2021.05.18.07.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:23:58 -0700 (PDT)
From:   Jussi Maki <joamaki@gmail.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, andrii.nakryiko@gmail.com
Subject: [PATCH bpf v3 0/2] bpf: Fix l3 to l2 use of bpf_skb_change_head
Date:   Tue, 18 May 2021 14:23:54 +0000
Message-Id: <20210518142356.1852779-1-joamaki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210427135550.807355-1-joamaki@gmail.com>
References: <20210427135550.807355-1-joamaki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This fixes an issue with using bpf_skb_change_head to redirect
packet from l3 to l2 device. See commit messages for details.

v2->v3:
- Refactor test_tc_redirect_peer_l3 to use BPF for passing packets
  to both directions instead of relying on forwarding on the way back.
- Clean up of tc_redirect test. Setup and tear down namespaces for each
  test case and avoid a more complex cleanup when tearing down the
  namespace is enough.

v1->v2:
- Port the test case to the newly refactored prog_tests/tc_redirect.c.



