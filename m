Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D1343B8DF
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 20:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235132AbhJZSDt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 14:03:49 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:59233 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbhJZSDt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 14:03:49 -0400
Date:   Tue, 26 Oct 2021 18:01:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thesw4rm.com;
        s=protonmail3; t=1635271282;
        bh=DSl6znPppfxPHYlfPoifwo5mROOeqTllEzgr/Y0TT28=;
        h=Date:To:From:Reply-To:Subject:From;
        b=nKfQGXsOe+nu4Bu/Uxxqx1eqmTNKloDIe3O+y7pvtkUTKidLgFsX1mIlWr9VM5Ygi
         fzpyoTN6sNAhYYKkINWE4jjvwM9PWJHfefuw5a2wvKaJLL6I4zpbp0s9vqCXWPlyaZ
         KgkSYvf+fbYm4SUsxw+pTSUbJMI/d+0Zpw7bQVvHgpvDNHevwsGWbsUFnBI3ABaw6f
         /l0HxeGJTFLtF5elxo+zeCxZblJ7HLP+rdhlhmM4d/QTXQ9BIa7+kYdAgmipVfYTdi
         zWyOYUgbmO599nvkQWJgUG30bIw4DfT+VFE/81jsgxwS0T5X9slnZW+JkemlRtHZ5e
         mFJHTTdwxMHNQ==
To:     bpf@vger.kernel.org
From:   Yadunandan Pillai <ytpillai@thesw4rm.com>
Reply-To: Yadunandan Pillai <ytpillai@thesw4rm.com>
Subject: Read large payload from struct mm_struct without ring buffer
Message-ID: <20211026180110.nfgozwtq7diptye7@bigdesk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I am intercepting sched_wakeup_new and am able to read command line
arguments for an event using active_mm within the current task_struct.
However, the maximum size for these arguments is way beyond the stack
size of an eBPF program. Is there a way to read such a large payload
into userspace?

I'm trying to maintain backwards compatibility so unfortunately ringbuf
is not an option for the time being. I've tried reading the payload
directly into a hashmap, but unfortunately can't read past 512 bytes
(max buffer size). Is there another way to reserve large amounts of
memory in a separate location and get a direct reference, so I can read
into it with something like bpf_probe_read?

