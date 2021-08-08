Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71F13E3CEF
	for <lists+bpf@lfdr.de>; Mon,  9 Aug 2021 00:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhHHV7u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 8 Aug 2021 17:59:50 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:57223 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbhHHV7t (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 Aug 2021 17:59:49 -0400
Date:   Sun, 08 Aug 2021 21:59:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thesw4rm.com;
        s=protonmail2; t=1628459965;
        bh=n8plPI4j6Kr77c97B5VEWI+pK299/Z77wwYXp+Kb+xs=;
        h=Date:To:From:Reply-To:Subject:From;
        b=QqK8o29N9suAH7l+hOpV8legX+Ra9SgDcRfXqWn5a8mbp9LzX2BR0MK3M4N9WZJNi
         C1j/CHU0JKPgauJ0sAQS/3IkkMROrbkshI3xzu+qJlqf13fcKGeJMs5o7IezzdaKSd
         vSRFIgspp76gfHhwV7olUNiokczzJ7pdEMfErs22HEjYOJCWlW6vZcQiVuX7xIayqK
         XirWITUrDBd/r9A22Y2tKspL/qq0m/K9CK+PItwdMRbB74XyN12nMXE/yxg8m1I45E
         u/T5kKISUWe+G7w3OiwATT01yH9DYKkJMMquogxi67yddxt0dzjHVQoSHrFRzGGV9J
         afDOAzQbnt0Zw==
To:     bpf@vger.kernel.org
From:   Yadunandan Pillai <ytpillai@thesw4rm.com>
Reply-To: Yadunandan Pillai <ytpillai@thesw4rm.com>
Subject: Update percpu array from userspace?
Message-ID: <20210808215914.weaqxmsqgvmtbvep@bigdesk>
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

Hello,

Conceptually, what would be the process behind updating a percpu map
from userspace? Looking up elements is fairly simple to digest. (For
example).

-------

int map_fd =3D bpf_create_map_name(
        BPF_MAP_TYPE_PERCPU_ARRAY,
        "map_name",
        sizeof(__u32),
        sizeof(__u32),
        10,
        0
);

int key =3D 4;
int values[nr_cpus];

bpf_map_lookup_elem(map_fd, &key, values);

-------

This gets the fifth element for each percpu array.

But how do you update the values in each percpu array from the
"values" array? If you can directly run bpf_map_update_elem() on the
file descriptor, does that mean that the updated value is automatically
replicated across all percpu arrays? What if you wanted to update a
specific percpu array?

