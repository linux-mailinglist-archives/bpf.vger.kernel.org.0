Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B8DA0E93
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2019 02:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfH2APa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Aug 2019 20:15:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33955 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfH2APa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Aug 2019 20:15:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id s49so2004632edb.1
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2019 17:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=HXiTUrgTpySDqJ2z0IlxRdwN/AdZPM9PRJWDyYhpIx4=;
        b=e45AO9NpuZXfOGepMifc4AUPa3t0G9HNLJF47YLc7KvpKfDYlLUXsWbDH+Ox2bJk6K
         VYy4b4AsZ1P8MUQAX9P+ezN47AUeq4yQEIO8yWmcoZ5roCARG2MvUVt3rD5qpLpuo4PI
         Rb7wyAGeBjWQaPMW9syxyBJdgbrXVULFUPptgKkOwB7lcJ21Mf1mBowRdOBTTtNivoLA
         nvjyehZPuY3TxuXV0xG+lYuwG3uMhwkGteIC1vedzAobSccRI73X3BexTK1oY22C4Hm5
         CYDDVXMYV99y0ImBhz0mhyOktBWHEl8PPOep3vvSJZliHZfT0ZJkCJ4T5+r7kcW4L9Gy
         o10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=HXiTUrgTpySDqJ2z0IlxRdwN/AdZPM9PRJWDyYhpIx4=;
        b=K4hhUf3881XZLO8St2zgTlmJ3vfg3b8bWElLpzCQqQS3typY2sQrC48Ghs4VVE0u/K
         y2fljeHQvtpPNbE6QZzk0gKcs4UkwAms6QoOZsoFQIOkJlEMp/Q0sSErWwO5I8uSlSAc
         WQQvS0bfKbAC/PAz1hpfcab+kEO0Lm4ho3uGWyGDbH5SXXGtdysAKZaMsP4q9F4eonXy
         UHFfri6FIkGxSwUUjbyHkkgXCEwPOO5SYJ7VKv+6sexnxBfFSvxA+lxioM7B+ZO5fDSx
         R+S8SSao0JFvjuVn5detoDRb1qw7DSzYRj3Us5ieSLn435TSnXeKzd90F+HzddmekfrW
         I+AA==
X-Gm-Message-State: APjAAAUDDX2d8iAQkQQA6QjivEsCyx3vx1TmMvJVZMYCCsrESny4JObZ
        imIyDZHzEu1MxMWzHMhvKGRiFw==
X-Google-Smtp-Source: APXvYqz4W1FQHE5dUOt5X8/Pj/tl8Yb2m0qydnOk+JGjbcp4O6ydKYlpMp4kKWu4l3Teq2GOsVaL/g==
X-Received: by 2002:aa7:da4a:: with SMTP id w10mr6942046eds.74.1567037728472;
        Wed, 28 Aug 2019 17:15:28 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id sa25sm124124ejb.37.2019.08.28.17.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 17:15:27 -0700 (PDT)
Date:   Wed, 28 Aug 2019 17:15:05 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com
Subject: Re: [PATCH] selftests/bpf: Fix a typo in test_offload.py
Message-ID: <20190828171505.105c2cf7@cakuba.netronome.com>
In-Reply-To: <20190829000130.7845-1-standby24x7@gmail.com>
References: <20190829000130.7845-1-standby24x7@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 29 Aug 2019 09:01:30 +0900, Masanari Iida wrote:
> This patch fix a spelling typo in test_offload.py
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
