Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BDF2D337F
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 21:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgLHUUH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 15:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgLHUUG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Dec 2020 15:20:06 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C5DC061793
        for <bpf@vger.kernel.org>; Tue,  8 Dec 2020 12:19:26 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id k10so3042425wmi.3
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 12:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=BUN76cwequ+/VYM+TfjP/RsLBiO7tCwwH45rVFT1fYU=;
        b=GB9bF4dH48O1e0DK+jTsZh4B37OqnHwxnW+X5RHvICetlFihb9vuCkPErxfa23tjrb
         Pet2IVW6VLn5YeD89+e5zaijde05qQ4JWh83Pt17ENTtvzAzVkliryrrbMcqEsxJE6QH
         B4TGkcNp24Rpfo2uezXlz/XhLgR1KdnggvwIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BUN76cwequ+/VYM+TfjP/RsLBiO7tCwwH45rVFT1fYU=;
        b=c+5JH0pPROEKVHeDmpMiEwQbQvKI8yr+beG9VaFk3SnnQJNsOFNPPpiewPPehHTQ/T
         yymoYvuRljsOJ6Z1G028y5fpJ0GGJVP7SAjJrgmaSYh81BAyn2+CPQxRloFrok3/jQnP
         k90M4bmzZDrhq+JiAvIjx6fcVAJGEl9PcN7JVoBKDutf033SM3dxt/RH56cGYm4OAld5
         zHz+yXBeTtWVx86+69+uUI+NtxX+Or8T2hSYwU+zQn3iMja8xvB5Bo305sTXJDHxsw8I
         LyoPpYYQcdz9mBn7DJh4eTFfw+uBu9aCPivJ5Rdq1KmLogw7sowg03yDUcVW8q6LwHmf
         ZsDg==
X-Gm-Message-State: AOAM533m09ypOA8YbeMbQR5i3XQVXfUEmEd2tnoTGF3656k17oT1e097
        rOreq448oYJu92YA8APCTkW7TQ==
X-Google-Smtp-Source: ABdhPJy9OAXN0byqbLPrYyv3q1GNjdlrT9zw1o/Vgfw3TCvskm6gQE5bhU9On/i/pWGL2X7bDHg0xw==
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr5240281wmc.102.1607458765212;
        Tue, 08 Dec 2020 12:19:25 -0800 (PST)
Received: from ?IPv6:2a04:ee41:4:1318:ea45:a00:4d43:48fc? ([2a04:ee41:4:1318:ea45:a00:4d43:48fc])
        by smtp.gmail.com with ESMTPSA id k18sm10472971wrd.45.2020.12.08.12.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 12:19:24 -0800 (PST)
Message-ID: <a057c7ee47aa82acebd0438b786cd424ad67f6d8.camel@chromium.org>
Subject: Re: [PATCH bpf-next v3] bpf: Only provide bpf_sock_from_file with
 CONFIG_NET
From:   Florent Revest <revest@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, kafai@fb.com, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Date:   Tue, 08 Dec 2020 21:19:17 +0100
In-Reply-To: <c8dd9a41-3e45-fb32-1074-e23ebe3cb2e5@infradead.org>
References: <20201208173623.1136863-1-revest@chromium.org>
         <c8dd9a41-3e45-fb32-1074-e23ebe3cb2e5@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2020-12-08 at 12:06 -0800, Randy Dunlap wrote:
> On 12/8/20 9:36 AM, Florent Revest wrote:
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> 
> I would say that I didn't ack this version of the patch (hey,
> it's 3x the size of the v1/v2 patches), but I have just
> rebuilt with v3, so the Ack is OK.  :)

Oops! I'll be more careful in the future, thank you Randy. ;)

