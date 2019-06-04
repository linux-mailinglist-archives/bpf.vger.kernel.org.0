Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76EA33525B
	for <lists+bpf@lfdr.de>; Tue,  4 Jun 2019 23:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFDVzj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Jun 2019 17:55:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37549 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfFDVzj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Jun 2019 17:55:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id d15so3894710qkl.4
        for <bpf@vger.kernel.org>; Tue, 04 Jun 2019 14:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=QuQtFtk34Azd7891Fc4iDw2uTV/2EPAFdVwzXutl5lw=;
        b=ljGUfVFtRDtXiqd3JeQ2+dwGjQ9Tbd7+FqDhJuQvyS0erW8W7oPxubUy2FJUiOdQtz
         2vKlh4frf5gayyYN1dRaAgO7MRXmYjRkfkehPrk+MQoiLrQLZSmwTO0nTQ4v1epw8x9L
         nXJ0yDr2aiRbMphtHAdLFAKf7v90VRRaeqbbWkqi9iDuddY3aB+JCUDSq2mI386tlRAr
         3j1bKH1+IsZW9beanAzRztjj3fA4TMLoOjiaZwqoWM9lUymxiu5v0YPH4+J7/PiZKGtm
         oWZXX4XJRIoVhcynDTnIUaHpppLtSTaRSF43bOFTCgziIheT7Pu738w2YeGxJljQWIqv
         Cdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=QuQtFtk34Azd7891Fc4iDw2uTV/2EPAFdVwzXutl5lw=;
        b=BQvK9aUajnAN1Sx26yV7roXmdT89yqogbvtHFdCjl4zGL7IwDkYIIrKxjSZzARWZ3D
         eL+LB6bVy+gOcMBS1el0Q7P63hbUEcj+EgWofcSqjE08a35MJUiMntSRo6ubs+JP1cAF
         a9pwn43LMMphbbni9kPIj96FpHFjKNY+z+89WoA6du3HABZskTaW3PO7ZE0pWLHoMRrw
         kBY9jzVTI/FbrMbyoxch+AvlDSR998KluHgt/4m6O03vz5ZhBI5hBfm6CFIl/WKwaRsI
         EzMWxaP/iqzcShtyWLp4Kndsy481TvPwptTApBwsN2YFHq7hmwmBAfDi/eQ0SRvFM2pt
         htYQ==
X-Gm-Message-State: APjAAAUOvzLZcgsbDUrBqpl05uYw6oDUtbNDuEDkfh/G6VIYG737UUpz
        ILWhkSaDhryBZ+GtmxcDCfA68A==
X-Google-Smtp-Source: APXvYqxvoKfqBBSgBMJMySc9IAfRGlrOI23txvOI+o4Fzeb9FtjfMMxUp5ZTiVH929G/zTnAUhErrw==
X-Received: by 2002:a37:dcc4:: with SMTP id v187mr29233382qki.290.1559685338165;
        Tue, 04 Jun 2019 14:55:38 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id o6sm11869989qtc.47.2019.06.04.14.55.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 04 Jun 2019 14:55:37 -0700 (PDT)
Date:   Tue, 4 Jun 2019 14:55:08 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH bpf-next 7/7] bpftool: support cgroup sockopt
Message-ID: <20190604145508.1364ddf8@cakuba.netronome.com>
In-Reply-To: <20190604213524.76347-8-sdf@google.com>
References: <20190604213524.76347-1-sdf@google.com>
        <20190604213524.76347-8-sdf@google.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue,  4 Jun 2019 14:35:24 -0700, Stanislav Fomichev wrote:
> Support sockopt prog type and cgroup hooks in the bpftool.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
