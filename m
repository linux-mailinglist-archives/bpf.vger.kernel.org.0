Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9954F48F5FC
	for <lists+bpf@lfdr.de>; Sat, 15 Jan 2022 09:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiAOI2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 15 Jan 2022 03:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbiAOI2j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 15 Jan 2022 03:28:39 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7899C061574;
        Sat, 15 Jan 2022 00:28:38 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i17so4923120pfk.11;
        Sat, 15 Jan 2022 00:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=efWehKZqRZyT3jLnEWgoS2SgOYAw1yEu1mXqwwUFMx0=;
        b=H74tADmE6ZvkeEHIAbwLaQ8zX5/lgfrN7ZV2mHIRWdDkDdxZQwCpjfhz0+AYkDeHYd
         OZByOV1UkTnHtR+zGkphNvPgwHdQcN12krpLbTpxmCT8djRqULTofnU9GJioE4uoutPP
         FQal7N2TNujqY7DuWNuTSvOnyNUbd+WILPoGOqC2yvA8Z5Gv2FhHnd+hjC1GJkjRqH7a
         5RA+mN87WNBNNYNbwAe6YKSZA40lpnxi6+xNJnTla7V69GRmYC7qTcXG7lYvfT1P6L+o
         iyQ0Xc1CmzktK0Tvdgk9sX/SLaikAv0PBPQEgYf0t7HwPnrI48ytt1SeA4KXqe8Ket3k
         TgAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=efWehKZqRZyT3jLnEWgoS2SgOYAw1yEu1mXqwwUFMx0=;
        b=DT1kKx7gtO36VzZq0q4s5t8W/Hv8onqLYp8Kko15TYHxT2ws1DAyLWF9iiqD9wfVKr
         UxIHL+tojLo7xRmLTE1wBXPu70V93vvWCN/Te+O4M/1EufcMRgcb54PqNiono/72RSw5
         kfkrlZimK7yo3G+JG6vpPNrcdERWFvvjToiBZGkN4epsc61kVfxmrfZ1j0X6lTA5ttzO
         wiATIwI+dyAuKRzDZAQ8r49N2ynxw/RXhcyIbcSZtrzS9FEqnHo9eHKS1G0bZoIF83xe
         eU9dyGkDUralH9wzg92rIH7ya57Go/vYyNjkL9eBrxcmtB3PecC4zct5mlsvm+hj5Pmy
         18OQ==
X-Gm-Message-State: AOAM533+D26ypv+o4I5ghvZHZL0FFSL9RuC06fevVie46gBnhUuH2SIr
        khQSVaAe+IcpB2IYGw0tqJs=
X-Google-Smtp-Source: ABdhPJzR7Ih/JG4YJEC3irQPMeanjUipcGm7OZiNQoSEEayTkcAcCCV0Tq/6nM6XaAlpwtoj6M8mkQ==
X-Received: by 2002:a63:eb07:: with SMTP id t7mr11147967pgh.112.1642235318501;
        Sat, 15 Jan 2022 00:28:38 -0800 (PST)
Received: from archlinux.localdomain ([140.121.198.213])
        by smtp.gmail.com with ESMTPSA id i63sm673577pfg.20.2022.01.15.00.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 00:28:38 -0800 (PST)
From:   Huichun Feng <foxhoundsk.tw@gmail.com>
To:     guro@fb.com
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH rfc 0/6] Scheduler BPF
Date:   Sat, 15 Jan 2022 16:29:24 +0800
Message-Id: <20220115082924.4123401-1-foxhoundsk.tw@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20210916162451.709260-1-guro@fb.com>
References: <20210916162451.709260-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Roman and the list,

I have a naive question regarding BPF hook for sched.

Given that BPF can also be attached to tracepoint, why do we add a BPF prog
type specific to sched?

The reason I can come up with is that sched BPF can have retval to drive the
scheduling decision in static branch, whereas tracepoint is not able to do this.
Is it mainly because of this or anything else?


Thanks
Huichun
