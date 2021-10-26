Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4212343B91E
	for <lists+bpf@lfdr.de>; Tue, 26 Oct 2021 20:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238101AbhJZSOq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Oct 2021 14:14:46 -0400
Received: from mail-4022.proton.ch ([185.70.40.22]:27622 "EHLO
        mail-4022.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238100AbhJZSOq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Oct 2021 14:14:46 -0400
Date:   Tue, 26 Oct 2021 18:12:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thesw4rm.com;
        s=protonmail3; t=1635271940;
        bh=RbpL8lnvbl41tu42hFFJfhxtCMBXNd1CPg5xF/iSysU=;
        h=Date:To:From:Reply-To:Subject:From;
        b=cz8UvOW5+Iusth4TDuJpG1r7W6atDF6t1+ljjGq+OhywQHn98caEK7XEh5f9J8xlf
         ZUfujs44u01f0mULnz3jR1PGGiBIy8E272AKqKGdWhmcDueppbzXKrgOAQriGGwvj/
         pj1KL6PR/3anHOoO19Uut9Ahnz/rsC+w2E3Pr59O4PNrFHl7rUOg9g/pFJVkLHNxQf
         KhTCkIY8gzqxiw35ygEEBsfoTT8+6IKdNY/8XdsT9sI7cZKzN+LwQ/WtqiZH3ycyPC
         c2ra+c/opb2iBeLN2bWQ+CmfN244vcXyM/Dkhe2FV2JWviICD4HQqfWjtC3HYMEA7W
         h2BESReLfOvoQ==
To:     bpf@vger.kernel.org
From:   Yadunandan Pillai <ytpillai@thesw4rm.com>
Reply-To: Yadunandan Pillai <ytpillai@thesw4rm.com>
Subject: Missing events when intercepting execve and sched_wakeup_new
Message-ID: <20211026181209.sumcxr5soyqf4xx2@bigdesk>
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

I am intercepting three tracepoints in an eBPF program:
sched_wakeup_new, sys_enter_execve, and sys_exit_execve.
To test it out, I spawned a bash shell and ran something
like "ps -aux | grep exe".

I think I'm misunderstanding how the two events relate to each other.
Here's an example result (not actual data).

Time    |       PID     |       Event                   |       Name
1       |       5       |       sched_wakeup_new        |       bash
1       |       5       |       sched_wakeup_new        |       bash
4       |       10      |       sys_enter_execve        |       ps
6       |       12      |       sys_enter_execve        |       grep
10      |       10      |       sys_exit_execve
14      |       12      |       sys_exit_execve

My question: why do ps and grep not trigger sched_wakeup_new? When would
sched_wakeup_new actually be triggered or not triggered? I assumed it
would trigger an event for each new process that's created.

