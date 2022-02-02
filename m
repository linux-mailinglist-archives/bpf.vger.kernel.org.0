Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDFC4A69F5
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 03:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbiBBCh6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 21:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243828AbiBBCh4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 21:37:56 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1F4C061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 18:37:56 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id e16so17119372pgn.4
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 18:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6A15sXNRT3iNpx8vp+3VW3SVrmEmyggoFKKDA0ZO/NA=;
        b=jL/orDAlXQXrQd9qpjac6LpBCCPOTYHyYTT8D/Cx5lxFovhyfb+VMFWiYodnvlIEtV
         6oaL8q0pwIkN2teuc2tDeJ20LE3bB9HVsbUo36T0LS/Ffcro+8dg8qiLu+Thc4NAJ4Hb
         qqLCHEKF+1hYpCY+BKawG6qX/3q8qcmMt5+f9gVXJeTqrkWbWC16fp3UZUziaTVgnnS2
         VhzOO6yr7kU3N+xswS6a/zSLdU17Lr3osha3+kLFz+tSZdFegZP1LVek5EcYbEF8XXbL
         cyysiKQiibGnDhtfVjODRpNebrKM7nSHdGyL6CvoVllCjcVvlv7kmU00AceOvKf7hCz3
         7YOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6A15sXNRT3iNpx8vp+3VW3SVrmEmyggoFKKDA0ZO/NA=;
        b=4/XxsFdE71e97JXBh0QNhwduJExD22Wx5RVCIySulYANNw1xVZgnqhDtdsPvHifLeJ
         MQKBah0MCvhIE4rfTjfufZXvcwMpwBis42ZEzJ0BMFWCf7PqkgUeRSx1sZQbUi6fQmeL
         9POQlmbTCBwsc3lSPJbPPvrJI4oOUBEcc50auVTb99TsJ0xtmGbYg492bngQ9uc+0mxL
         a7WNoNpDr2O3TvnYj/D3bsj7yTPczeUSaLNCq+mFbbE0ziWTW0OsiVVc+QTYSgovCPJp
         ZTN6rZoiHOeiLhvNsFZgi73v9gnbFo6Ps7KbW50leYOOrhnwIZ9vM362gZ/gngAWAehc
         mqNg==
X-Gm-Message-State: AOAM532hWG2elvmwCFT/FdagIrhfs1QQHohrFOWGpgr/d9pK694rXTxP
        aG9H266C2kxn5z7GN+pqR1hfH+msO2SM3A==
X-Google-Smtp-Source: ABdhPJxUMMdyXqb6wanaAr35uZXQ9K0HdZZ+AXG9mO8CqttX2SvAnkwWNDLICy87PX7zigZB1qOtWg==
X-Received: by 2002:a63:9307:: with SMTP id b7mr22897706pge.291.1643769475792;
        Tue, 01 Feb 2022 18:37:55 -0800 (PST)
Received: from localhost (61-223-193-169.dynamic-ip.hinet.net. [61.223.193.169])
        by smtp.gmail.com with ESMTPSA id j19sm12701594pfd.125.2022.02.01.18.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 18:37:55 -0800 (PST)
From:   Hou Tao <hotforest@gmail.com>
X-Google-Original-From: Hou Tao <houtao1@huawei.com>
To:     houtao1@huawei.com
Cc:     andrii@kernel.org, ard.biesheuvel@arm.com, ast@kernel.org,
        bpf@vger.kernel.org, catalin.marinas@arm.com, daniel@iogearbox.net,
        kafai@fb.com, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, yhs@fb.com, zlim.lnx@gmail.com
Subject: Re: [PATCH bpf-next v2 0/2] bpf, arm64: fix bpf line info
Date:   Wed,  2 Feb 2022 10:37:51 +0800
Message-Id: <20220202023751.4790-1-houtao1@huawei.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220125105707.292449-1-houtao1@huawei.com>
References: <20220125105707.292449-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

ping ?
