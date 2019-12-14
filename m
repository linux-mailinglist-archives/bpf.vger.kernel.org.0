Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A74B11F40D
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2019 21:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfLNUxM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 14 Dec 2019 15:53:12 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43224 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfLNUxM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 14 Dec 2019 15:53:12 -0500
Received: by mail-pl1-f194.google.com with SMTP id p27so2714880pli.10
        for <bpf@vger.kernel.org>; Sat, 14 Dec 2019 12:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=rtMnnzrU27f2aNSxJLAHQ6Cwu1ukVL6sYLz0eOE3Mwo=;
        b=saRF//ZzbRWEm3tRLHhMJHD1+oHatpjbgJ8nJ1Wm7ZlO0Cai+SfYEmbby5F0o2MjQe
         G5BpWPIx/ljGN2310DtLHIjuDgyS5+3lsyuK/ZyGQeUuX53PRjxsVfy1RB76zo1EplHn
         O6BgdLK3oweBenlhBxDnnEvtAoWLwJziLXMcAgr3F9JE05MORDWU+moJb+Rlh1+IghzQ
         EU3224uzSvxKmYAcNSaZRkUWbMNoSKbu0FOPS0PEUZbNC4qremw8GPiBa4orax3OuOO6
         UEdawv/yksYHFkRP8un4VuTAveXrcnG100O0yQSL4qVUzyuyKHBl9z+KK0Q0bjD6klN6
         XKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=rtMnnzrU27f2aNSxJLAHQ6Cwu1ukVL6sYLz0eOE3Mwo=;
        b=LdItCUW1l4GjAgge3eU2mDZ8HYOcCn61cuL1S2LRVgIBxaNQAzZl8iHdaal4Pk9nFC
         Uh7r5cHBeK8wSkw+UOH8bWlqQ36ySNKtIjWbRnYVlxbLsXC4zqGRKB78h5sKhBsYrg2r
         LMs3ARN846u5e+HQRJX//G3W5fyXd9+v1cWxsqXEdKi6M5/EBpW+jibky55pXcp2s3Gv
         KH4njVt2w+AdD4Fi3Xehi8ZG0dn1SIXiWtqqtB+3CkFH9RufxxTD3YPpfW0R4nm+aGWL
         bZdJIxQUiUHUSaYac+y+toIBkX3gh6VL0m8qexk8bTN4kVt9QEIBN51tQiEkWHPsysXi
         6ywg==
X-Gm-Message-State: APjAAAXnz1pi5E7fn9fdRElimuATeOD3RGLOW5QDgA4mawqJK4XaytNi
        DLEYj+qxTQqRC4IkAjKKmUiMaA==
X-Google-Smtp-Source: APXvYqyrV3DH1IJy1jJ/ibvpQxmiRqHTjGz1rrLT453ZdR3lLV1Yi6kx0BS+G3Vw0w0U5inCxPodcw==
X-Received: by 2002:a17:90a:3586:: with SMTP id r6mr7766095pjb.36.1576356792040;
        Sat, 14 Dec 2019 12:53:12 -0800 (PST)
Received: from cakuba.netronome.com (c-73-202-202-92.hsd1.ca.comcast.net. [73.202.202.92])
        by smtp.gmail.com with ESMTPSA id ce22sm13768058pjb.17.2019.12.14.12.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 12:53:11 -0800 (PST)
Date:   Sat, 14 Dec 2019 12:53:08 -0800
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] net: ethernet: ti: select PAGE_POOL for switchdev
 driver
Message-ID: <20191214125308.6551a6e3@cakuba.netronome.com>
In-Reply-To: <20191211125643.1987157-1-arnd@arndb.de>
References: <20191211125643.1987157-1-arnd@arndb.de>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 11 Dec 2019 13:56:09 +0100, Arnd Bergmann wrote:
> The new driver misses a dependency:

Applied both, thank you!
