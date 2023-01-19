Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B328673F5C
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 17:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjASQxJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 11:53:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjASQwj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 11:52:39 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C9D7F9BB
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 08:52:30 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m3-20020a17090a414300b00229ef93c5b0so1652108pjg.2
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 08:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6QGfk59rwIeg+XhQWLICj9/beKrpjZV39AZ2vUX9R1E=;
        b=D+nAM7QEAhiiTdVWh+ODvf/iWQXevJkY+WGH9jXCc2IVx2XiYo+sXpbPe0oBznnqt3
         b1TP5yfGaAHhjdAJ8W34yugcBt2OroUIdaWmdbS+fDZzawT1p67v+hqiJhkVVmRiRaTb
         81B/0agS/zvZ7YVMPjbXx4jn4V/MQ3BPeTLDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QGfk59rwIeg+XhQWLICj9/beKrpjZV39AZ2vUX9R1E=;
        b=mrBoVUuSQ6kazOB6SQoP9RAmLO2CIRXyh8H7IlMGsCxk6cjy7g+KsN4EJ/uka/5v6e
         etEnYOX8NoT1czPdA3st8u35EKti+6LaiTomcC+tjOmBXPM4WvDyNwgZYlaxo25Xnm2z
         snZ6J3abFyaZwChHnIZR5MhzVt1SxKbPky1q7RyVJ12Hjs5CIhf8DV7Jr0HD4HIj1JPY
         3Txji6X2CoOcjK6gxo/8PdXqfo7MDmAuIprmuwofYxpYZR24JY5M0aUQLIQv1sN76JHV
         C1b+DD0QcIXqmZs2NQc0vhh1RC+x0pRk0/YaW2c5Z4VTvbgie8VKMj4z+z7/HDJDmqfV
         i9pQ==
X-Gm-Message-State: AFqh2krm4WTpimAmkD6lAyMQ4oMD1ePdXf5aRH08ADFFZxXEw8K9GvGa
        lQ0HKm9CG+fYIrmHNqGFhltGiA==
X-Google-Smtp-Source: AMrXdXutvFC5QsUYb8WAHmLiIFAXP4i7mqFr154oyvWWagLODkSnT/yUiaYpajKBu5gjTteANLgDJg==
X-Received: by 2002:a17:902:e84e:b0:189:aedf:677d with SMTP id t14-20020a170902e84e00b00189aedf677dmr40590087plg.69.1674147149945;
        Thu, 19 Jan 2023 08:52:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i16-20020a170902cf1000b00192c5327021sm25420530plg.200.2023.01.19.08.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 08:52:29 -0800 (PST)
Date:   Thu, 19 Jan 2023 08:52:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     torvalds@linuxfoundation.org, x86@kernel.org, davem@davemloft.net,
        daniel@iogearbox.net, andrii@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, hsinweih@uci.edu, rostedt@goodmis.org,
        vegard.nossum@oracle.com, gregkh@linuxfoundation.org,
        alan.maguire@oracle.com, dylany@meta.com, riel@surriel.com,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH bpf 1/2] mm: Fix copy_from_user_nofault().
Message-ID: <202301190848.D0543F7CE@keescook>
References: <20230118051443.78988-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118051443.78988-1-alexei.starovoitov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 17, 2023 at 09:14:42PM -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> There are several issues with copy_from_user_nofault():
> 
> - access_ok() is designed for user context only and for that reason
> it has WARN_ON_IN_IRQ() which triggers when bpf, kprobe, eprobe
> and perf on ppc are calling it from irq.
> 
> - it's missing nmi_uaccess_okay() which is a nop on all architectures
> except x86 where it's required.
> The comment in arch/x86/mm/tlb.c explains the details why it's necessary.
> Calling copy_from_user_nofault() from bpf, [ke]probe without this check is not safe.
> 
> - __copy_from_user_inatomic() under CONFIG_HARDENED_USERCOPY is calling
> check_object_size()->__check_object_size()->check_heap_object()->find_vmap_area()->spin_lock()
> which is not safe to do from bpf, [ke]probe and perf due to potential deadlock.

Er, this drops check_object_size() -- that needs to stay. The vmap area
test in check_object_size is likely what needs fixing. It was discussed
before:
https://lore.kernel.org/lkml/YySML2HfqaE%2FwXBU@casper.infradead.org/

The only reason it was ultimately tolerable to remove the check from
the x86-only _nmi function was because it was being used on compile-time
sized copies.

We need to fix the vmap lookup so the checking doesn't regress --
especially for trace, bpf, etc, where we could have much more interested
dest/source/size combinations. :)

-Kees

-- 
Kees Cook
