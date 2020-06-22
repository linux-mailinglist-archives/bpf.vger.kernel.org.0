Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94B3203D59
	for <lists+bpf@lfdr.de>; Mon, 22 Jun 2020 19:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgFVRBK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Jun 2020 13:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbgFVRBK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Jun 2020 13:01:10 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703D0C061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 10:01:10 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id o4so9442659ybp.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 10:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWY9Yn7J/i3Psng56Zw4vcf9J/l6EWuVA4uqFG2U6+A=;
        b=b1euIfwWZJ6L1moilOlgRz8Oyl+9T67zU5yUFbTxjANqTDVcIHtZVsP2K0TYzJxkt3
         /CntzlMDYpZTST/bRkSW3yFk+bz56B/WNYDIvn75h3+839kHkX4sgty+FMCfMjP5gTbm
         Vfc7XqV1Z4IJ55EiQgU+bJ/fWoT7MN5yPzyVzVulzwIRgFPdCVYWdM5veFz+aJgIP/Xx
         3Lw5cjfJcmUjj8/3g/Txy0Wp8ULusCwmbCO4nnkB94dsdBcJpj4P4OJa3yNQI9sdotfv
         0kHqLoTVMiNsJYkpO7Lugmf8NePHffQa78T5em5Pv4jqF9OxI9/BGj9O35pUmqZ+JI4S
         YbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWY9Yn7J/i3Psng56Zw4vcf9J/l6EWuVA4uqFG2U6+A=;
        b=CDEqUfLrOtvIYhAsuEy6Irb4b/4Q2OKJ2/kD96JZugY7lnQxKB4b80RP2jaSF1VcDm
         O8H+lKJuqN4DREuF4PNsCuCqkenk4T8RXRu8bwMON+NsqtiKDJcDRF1HVgagNy8b1sKy
         oUnFbBbNqIqK5RENIukPyGXNg7F1iyAGcHB5t20nxE/xXO4OYM2cJEDlCq2meMTw42f7
         U7kycNuvUq3Gx1hELFkzX0UKMAdzTrlX28CVXzSKTvK0m2pIM0RNvLz0KrJHuU0EBOYV
         VIt5mrwCLIEIHFKjzkIKtbY/SQus5nSV7ZP/qjAlT6vtavDoUHAy+qXzCMVLURhXI4N/
         vSsg==
X-Gm-Message-State: AOAM531YvV+o6Y1gJslx+bO6DEwgaKbudpVX1OK0Exql0ZcnwU25plKZ
        vTTp649vtmp4EPXVd0CGvVxzZTjMCX0sTyRWFv7wXTqM
X-Google-Smtp-Source: ABdhPJwBHiksXlZGNYRiDbpblvi+etifLRO+XXhFJHo/kb0Y5Re6dhc/RwD4LaAu0VEjx58JIGix6yfFiZv+tSThkIA=
X-Received: by 2002:a25:b8b:: with SMTP id 133mr30479369ybl.373.1592845268472;
 Mon, 22 Jun 2020 10:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHhV9ES1aUO-Zfpz6uCnFhY3Rgi3ZS1pn4ztz2iXYFO-KX75BQ@mail.gmail.com>
In-Reply-To: <CAHhV9ES1aUO-Zfpz6uCnFhY3Rgi3ZS1pn4ztz2iXYFO-KX75BQ@mail.gmail.com>
From:   Abhishek Vijeev <abhishek.vijeev@gmail.com>
Date:   Mon, 22 Jun 2020 22:30:57 +0530
Message-ID: <CAHhV9EShCxg=W2Yhsehx6KQGYPQ9KjF7jmteoxiNO-8ma-WmLw@mail.gmail.com>
Subject: Re: Checkpoint/Restore of BPF Map Data
To:     bpf@vger.kernel.org
Cc:     criu@openvz.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

+ CRIU Mailing List


On Mon, Jun 22, 2020 at 10:29 PM Abhishek Vijeev
<abhishek.vijeev@gmail.com> wrote:
>
> Hi,
>
> I've been working with the CRIU project to enable CRIU to checkpoint
> and restore BPF map files.
> (https://github.com/checkpoint-restore/criu/issues/777).
>
> A key component of the solution involves dumping the data contained in
> BPF maps. However, I have
> been unable to do this due to the following reason - as far as I'm
> aware, Linux does not provide an
> interface to directly retrieve the key-value pairs stored in a BPF map
> without prior knowledge about
> the nature of data stored in it. To explain what I mean by 'without
> prior information about the data
> stored', let's take the example of a BPF map that stores key-value
> pairs in the form of a hash table
> (BPF_MAP_TYPE_HASH). The only way to iterate through all the key-value
> pairs in this map is to use
> BPF_MAP_GET_NEXT_KEY. However, if I start with a lookup key that
> exists in the map, I will only be
> able to iterate through the key-value pairs that occur after this key.
> Therefore, I must start with
> a lookup key that does not already exist in the map, so that
> BPF_MAP_GET_NEXT_KEY returns the
> map's first key. However, information about the nature of data stored
> in the map is only available to
> the application programmer, and it will hence be difficult for CRIU to
> guess a key that does not exist
> in the map.
>
> I would therefore like to discuss the possibility of extending Linux's
> BPF API to provide easier
> access to the data contained in BPF maps, in a manner that works for
> all types of maps and is
> potentially future-proof for other kinds of maps that may be added.
>
> As I currently understand, this problem stems from the fact that
> reading and writing to a BPF map's
> kernel buffer is only possible using the BPF system call. Therefore,
> functionality that allows
> reading from and writing to the map in a manner that is agnostic to
> the nature of data stored in it
> (similar to tee and splice for pipes) would enable checkpointing and
> restoring BPF map data.
>
> Do let me know if anything I have written is factually incorrect and
> also if there is something I
> can explain more clearly.
>
> I look forward to hearing the kernel community's thoughts on this.
>
> Thank you,
> Abhishek Vijeev.
