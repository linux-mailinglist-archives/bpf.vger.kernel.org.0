Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60E9D155BFE
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2020 17:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgBGQlL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Feb 2020 11:41:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43820 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbgBGQlK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Feb 2020 11:41:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id s1so19982pfh.10
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2020 08:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ZRvofd/DMmPC/OMPUBWDllNF6s2U7sb8/8XSEwa6JXA=;
        b=XJJ0JACTq1ESsC/yaDWLvU3gVPFoTG3CenrcKirPe6wlEk0ynPMYkyXBWbAk78O3JF
         K1QJZ3Xz00k89ehDzCyWGqmO2OwjKOtJFrZhLkqlLmLixrzh5t6ArxRcAan7Ora2b+ln
         Iy0orv/hMpPxWYYi4HK5i18wBzl1Ua4oUeA/I0/w2Cc+YDVYIRbTz/tAIxebNJ+dAmLY
         83W9n6n/Sl/RzNGcfu6PTAccdNZmbKhSMrLJdWqXa2+F2GuLiV8AbLwxe0gvBtnYE8bK
         qyeBJbRaWC/CW4+i6BXhs32Jin4GZFfW7/0NcrAl/BdkVWQjQhPprzurnA+ISx7WL67m
         +XWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ZRvofd/DMmPC/OMPUBWDllNF6s2U7sb8/8XSEwa6JXA=;
        b=KMn9XrrMrnqQIk/F22c8m8KXI85sL1VasihVN3M9/8G+tYCgqsMvx/IETY7ttcJJO+
         vheEprm7Rz1f+Zp+rXGeSJ7MqMexJCiHrz3YQ+6QNqVvZWxA29qyyAdy+HUuHL/vzrpC
         FHgYuFI6rQjgHA8HLVUYm44KEVwOH7s1VXSFpaxDsNSxzSnq/x2k3LWMqgIwLmE3FI0L
         BiDp7NXHsQbt0yJ+M9VpXvYPNUKtpq+tF0/ttuXD8y3sysUaTQF2WQQe1fCoQH70hhbc
         yBeTj1Nj7YljFhqMjtR0TOvaNq0KoVjvfteNseeENY9E8xxS46xvi5S+8R/9pkG3M68o
         tDSQ==
X-Gm-Message-State: APjAAAXsswoDd+/+fxiMtfeJRuqIltp4iTorMiBHhIaxqfQkU2y8yqFY
        1YqqXU5M9y5CuDUPV4keOeTMxg==
X-Google-Smtp-Source: APXvYqw5NRhjkdqGxSWnp7ivRI4G6zvKdAFqLBmtLYjJ/6x14Gv5/UBFBeC13W6UvGzCVXli+vxtJA==
X-Received: by 2002:a63:8349:: with SMTP id h70mr116564pge.396.1581093669103;
        Fri, 07 Feb 2020 08:41:09 -0800 (PST)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id t19sm3524823pgg.23.2020.02.07.08.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 08:41:08 -0800 (PST)
Date:   Fri, 7 Feb 2020 08:41:07 -0800
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf@vger.kernel.org
Subject: [LSF/MM/BPF ATTEND] BPF track
Message-ID: <20200207164107.GA1400227@mini-arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I'd like to participate in the BPF track of LSF/MM/BPF Summit 2020. I
work on BPF stuff at Google, I recently contributed the following
features to the upstream BPF subsystem:
* {set,get}sockopt hooks & BPF_SOCK_OPS_RTT_CB callback
* Optional socket storage cloning on accept (BPF_F_CLONE)
* Improvements to flow dissector BPF hook to make it work in driver
  (non-skb) context
* Various improvements to selftests / BPF_PROG_TEST_RUN framework

Topics I'd like to discuss:
* BTF/BPF meta-information: how to append enough info to BPF/BTF to
  recover build timestamp + commit sha1
* Global mode for cgroup storage as a way to have common/persistent
  per-cgroup scratch buffer
* Unit-testing and uBPF; uBPF integration with libbpf
* Average prog runtime; discuss any future plans to extend it to return a
  distribution, not average (with BPF?)

I don't think my topics deserve a dedicated 30-minutes session. I'm also
interested in general BPF direction and how we can apply future
potential features here at Google.

In particular, some of the proposed talks that are of particular
interest:
* BPF logging
* BPF unit testing
