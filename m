Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8817E21F839
	for <lists+bpf@lfdr.de>; Tue, 14 Jul 2020 19:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgGNRb6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jul 2020 13:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgGNRb5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jul 2020 13:31:57 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9549DC061755;
        Tue, 14 Jul 2020 10:31:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q17so7861712pfu.8;
        Tue, 14 Jul 2020 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p4yQKBD4fuwZyX2aETXM/9xgpuX9woM9ISDFBgC0eEo=;
        b=hgdDu5IXgKoUF/NpPM3mJGnRCEDFXInBPWokzl3DS3yeuLSlVIr2+DWjzs99yFe8z1
         JpqDSj05bcmw1cxyu79Uqa0D2ZKvneZq+bEJbQIkodfwEUvofIew2PljkoB0L7agyNBz
         +RH94KpBuar0gPe+YNG0sLXCipU+jfW6M4WcLAdJr6XJ63fvKwFpgx6HCDDc83jOZ0WJ
         EdGC7a708SugCkaPTC+CxN+lNWs40CRowBZMF0wzGl1288zbJShWB+XAx8n+GVgu6ag+
         u2s8xgD2FVBVz7TfvLE2x6Mvf4Ux66G8PEWqLdvL3d/GoX6kWoF+eUXjn809ySXLtCyb
         XyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p4yQKBD4fuwZyX2aETXM/9xgpuX9woM9ISDFBgC0eEo=;
        b=V+N56I0btL/HrUb2Xr1J5AvxayjRuTsYH5Bz8+DA0kHG+mfCffhXTMO7ZOzAj2qYU6
         Aj75TVT4kegMBuMkfGBHvT0XpPZyFycIKZkBdMtAYBS20P5zZ0ARGBoU4OGHRGvPWd+W
         FeyEfJkZgCBQw31UWDYo3ycaPyFIFESRMHSdngKOzJDS8LEa1/cSl9eaKZCoTNRTVKd5
         ScSLF9XLRoHXST8tbhNK6OFMNjE9fWE0qFwMphWqAwxB5miNGIhcLNVgkHEcCokz3aAT
         Y5lan4fHjlQcZAzGyXB2y1mhbih4UCa0x+8RgRvM82PvKk2HrRv+rD6DvTch2eo9sFCZ
         XMiQ==
X-Gm-Message-State: AOAM531eOB3XQZpRJGuP7GTsdXw9xDRhTzjIatW1CJ0xfWZM8XMgCmDC
        qSyVY6RK/G3EoRFCbTlI2wOXGf0m
X-Google-Smtp-Source: ABdhPJzFRXKIoZ8eRflYavclbmHPZtFmEJ0GgvuIIIgy8GHja5RF5nIXHemnbhLV8L3FnH9d+OoR/g==
X-Received: by 2002:a63:481:: with SMTP id 123mr3960220pge.2.1594747917115;
        Tue, 14 Jul 2020 10:31:57 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:96f0])
        by smtp.gmail.com with ESMTPSA id q6sm17745902pfg.76.2020.07.14.10.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 10:31:56 -0700 (PDT)
Date:   Tue, 14 Jul 2020 10:31:54 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next] bpf: allow loading instructions from a fd
Message-ID: <20200714173154.i2wxhm4n4ob7sfpd@ast-mbp.dhcp.thefacebook.com>
References: <20200713130511.6942-1-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713130511.6942-1-mcroce@linux.microsoft.com>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 13, 2020 at 03:05:11PM +0200, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> Allow to load the BPF instructons from a file descriptor,
> other than a pointer.
> 
> This is required by the Integrity Subsystem to validate the source of
> the instructions.
> 
> In bpf_attr replace 'insns', which is an u64, to a union containing also
> the file descriptor as int.
> A new BPF_F_LOAD_BY_FD flag tells bpf_prog_load() to load
> the instructions from file descriptor and ignore the pointer.
> 
> As BPF files usually are regular ELF files, start reading from the
> current file position, so the userspace can skip the ELF header and jump
> to the right section.

That is not the case at all.
Have you looked at amount of work libbpf is doing with elf file before
raw instructions become suitable to be loaded by the kernel?
