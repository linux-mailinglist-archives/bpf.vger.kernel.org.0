Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EA43B59C8
	for <lists+bpf@lfdr.de>; Mon, 28 Jun 2021 09:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhF1HeZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Jun 2021 03:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhF1HeX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Jun 2021 03:34:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1830C061766
        for <bpf@vger.kernel.org>; Mon, 28 Jun 2021 00:31:57 -0700 (PDT)
Date:   Mon, 28 Jun 2021 09:31:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1624865514;
        bh=GtfBo6P8teq4bX0PeFtT0D/ojACshn8SCvUnRDe32k4=;
        h=Date:From:To:Subject:From;
        b=rAeW7OgnbnQVXQrpaWXAnk9anUIOMLyBPFwyUacyCKoJguiz4gIczc8pYJSrKR9pG
         uMP3lQ2boJ8J+gpRe82/XGW6FWG2fEz7MOlHmQlxR6+MUcAlDJB3Q+UR7V6JcITg0+
         olWFBHd0sfX7oZI+EDwn9HlCumPquNfT/TujabMg=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     linux-audit@redhat.com, bpf@vger.kernel.org
Subject: AUDIT_ARCH_ and __NR_syscall constants for seccomp filters
Message-ID: <0b926f59-464d-4b67-8f32-329cf9695cf7@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone,

there does not seem to be a way to access the AUDIT_ARCH_ constant that matches
the currently visible syscall numbers (__NR_...) from the kernel uapi headers.

Background:

I am writing a seccomp BPF filter using the syscall constants to get the
correct syscall numbers for the target architecture.

seccomp_filter.rst tells users to always check the arch values.
But there does not seem a way to get the correct AUDIT_ARCH_ value from the
kernel headers.

Questions:

Is it really necessary to validate the arch value when syscall numbers are
already target-specific?
(If not, should this be added to the docs?)

Would it make sense to expose the audit arch matching the syscall numbers in
the uapi headers?

Link to the actual BPF code:
https://github.com/t-8ch/qmk_firmware/blob/optimize-udev/util/udev/qmk_id.c#L154

Thanks,
Thomas
