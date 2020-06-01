Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7721EA5A4
	for <lists+bpf@lfdr.de>; Mon,  1 Jun 2020 16:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgFAOQr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 10:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgFAOQq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 10:16:46 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8223C05BD43
        for <bpf@vger.kernel.org>; Mon,  1 Jun 2020 07:16:45 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id q19so4064089eja.7
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2020 07:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0RXojda16OnGmgNKSmtyw7Ld824D2dHnKxVXAUlbFzY=;
        b=WpEPYsC/ouh8NovMeea6DUrUXsf+lzEHm8v1a0KYLtGsk+v/WgYML58SySY8kzD0M6
         LWLBesNp0LiPUYwcVKUSU2JY01tohZ9kgJUjGphJuJrKtlz9p9GJucOTnx2MNTcqhtU7
         feRrBOkjkQTEBWzj0nmPugJaW+2MPLnJttSVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0RXojda16OnGmgNKSmtyw7Ld824D2dHnKxVXAUlbFzY=;
        b=iOA2gTg+nvNRbD5CXf5qI5WTZcknFX2RNwz0TNUB6sEN8W3rGQj0FKSQKiHzh77ZBo
         NvXTDzMts81r+bmP4OEG06IAtwAaaAct2o6I1TnXlXpt78vUZpEGJDeJfT2psN/Ayu0d
         Ln5DeeoI312TV4dlZ+oVYOS4z3yJomv95q1qEv2nNoymmO0ycKfqelkQtGqedZU6Qbbt
         /WLAf18YAuiDv++DmP+3d+nYlUyNg0LbKHpXquEXoRjwuH31FW20TCGdsy2dpGRi/rUi
         uLslOHKabaX1iq1zLyT2qUIYe2J8g9875P/lg8zY0QcBkeQubSxD0wRI/VAREl7A9OF4
         nFJA==
X-Gm-Message-State: AOAM532whWUKeflx1m2Ee8nbsSvumJU4lt+ydAk4UJcVH4LZErxXHkLy
        5Z5eJJN7c59bZsxQrY0rYCh+xA==
X-Google-Smtp-Source: ABdhPJz3oDHtYW6LNlLnXVNxbQecxUE4mFbdUo8WW2phtjh2jfRhgHK3IHNuF6iZ3E48SSkesyI4kg==
X-Received: by 2002:a17:906:818:: with SMTP id e24mr8375878ejd.453.1591021004391;
        Mon, 01 Jun 2020 07:16:44 -0700 (PDT)
Received: from toad ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id w13sm5759430eju.124.2020.06.01.07.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 07:16:44 -0700 (PDT)
Date:   Mon, 1 Jun 2020 16:16:14 +0200
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net
Subject: Re: [bpf-next PATCH 1/3] bpf: refactor sockmap redirect code so its
 easy to reuse
Message-ID: <20200601161614.4bea42b0@toad>
In-Reply-To: <159079360110.5745.7024009076049029819.stgit@john-Precision-5820-Tower>
References: <159079336010.5745.8538518572099799848.stgit@john-Precision-5820-Tower>
        <159079360110.5745.7024009076049029819.stgit@john-Precision-5820-Tower>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 29 May 2020 16:06:41 -0700
John Fastabend <john.fastabend@gmail.com> wrote:

> We will need this block of code called from tls context shortly
> lets refactor the redirect logic so its easy to use. This also
> cleans up the switch stmt so we have fewer fallthrough cases.
> 
> No logic changes are intended.
> 
> Fixes: d829e9c4112b5 ("tls: convert to generic sk_msg interface")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---

Keeping out_free in the extracted helper might have been cleaner.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
