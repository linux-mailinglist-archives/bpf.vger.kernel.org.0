Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA2D3FD38E
	for <lists+bpf@lfdr.de>; Wed,  1 Sep 2021 07:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242408AbhIAF5o (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Sep 2021 01:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242424AbhIAF5l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Sep 2021 01:57:41 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F13C061575
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 22:56:45 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id h29so2239235ila.2
        for <bpf@vger.kernel.org>; Tue, 31 Aug 2021 22:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ab9dCeXFojyhI4yjSjv4X3ZZAv+fxXV+6Shjh3OSdVI=;
        b=e4r8WHj0nRTXoPIfAI9MwWAx7EgQq/Ft+HT/yXIhS0nQqj663Bj/V3bwHiYITREjN4
         wxEJLlDjUoOiKLaQX4h4PUFCVJIqfy4rPILpZYx3KINuBfZfYtGKFBAO7RFTLybhjue3
         d5NypKOX7qtqG/SsTrm1EcHxbrMhVIocvui2M0ob7dVOai7QmO8sbgy7L6RlFlYeivU4
         kg9WixwHs3cLYmKFKHFYHG626PFFCt74g1oZ5aQG6l0Mg6cSUBXhgJfuPQv90X4CXyOK
         0G3WZLbzC4kKGqCEoV81JA5Zzaa/nRuHc6lCZRQqm75/o6U/HYXYLVi6HvIlzvgf+GAx
         of9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ab9dCeXFojyhI4yjSjv4X3ZZAv+fxXV+6Shjh3OSdVI=;
        b=sOi3UgyjG7n71nFfjvAKxxv60Lf55R4XijjLXQ4x4pOuZ5NgkfIZ+fjt97DSOpNIHz
         NSy0TKapBx21uQtZW6Z8x08p3zp3XcXoAoJVzcQunjOBK8SA7RrDHnO0cftT5vRJ9lHx
         VyDvHKrnszJ8kMG75tcqEEpuY2n8L1/QHmPW/QRPTBoCBNp/1pAKiN0T84dZLJo12xFX
         yYyHy8B8joKiS+4OEN90IjrgFREYsyqwVLIrc7qfPtATZSKhvRWrb1tqGC4Ov03Hv7Tl
         ifPtaFqhDnwOFpF8EPhKw0ZyqWfGvxc7zp9BQ5G4QBJCGSiCzpd3++bPazK5XUg5z0xa
         rvrQ==
X-Gm-Message-State: AOAM530dsw8xZaiRZOyDYc/tFogqVtguPgBcgyO27VRvkT4as0Tckjw4
        Z0oCW0PAVweD+uJYlUecptE=
X-Google-Smtp-Source: ABdhPJwZmUYDogPk9I1GjuiQ4Owf1GD8/WQlsPnc5KOv4W8UfirhAcwku16IIy/hFLQ/sW7Lt3XtcA==
X-Received: by 2002:a92:4b01:: with SMTP id m1mr21509549ilg.50.1630475805051;
        Tue, 31 Aug 2021 22:56:45 -0700 (PDT)
Received: from localhost ([172.243.157.240])
        by smtp.gmail.com with ESMTPSA id a14sm11208578iol.24.2021.08.31.22.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 22:56:44 -0700 (PDT)
Date:   Tue, 31 Aug 2021 22:56:37 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Neil Spring <ntspring@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net
Cc:     Neil Spring <ntspring@fb.com>
Message-ID: <612f161528808_152fe2084d@john-XPS-13-9370.notmuch>
In-Reply-To: <20210831033356.1459316-1-ntspring@fb.com>
References: <20210831033356.1459316-1-ntspring@fb.com>
Subject: RE: [PATCH bpf-next v3] bpf testing: permit ingress_ifindex in
 bpf_prog_test_run_xattr
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Neil Spring wrote:
> bpf_prog_test_run_xattr takes a struct __sk_buff, but did not permit
> that __skbuff to include an nonzero ingress_ifindex.
> 
> This patch updates to allow ingress_ifindex, convert the __sk_buff field to
> sk_buff (skb_iif) and back, and test that the value is present from
> tested bpf.  The test sets an unlikely distinct value for ingress_ifindex
> (11) from ifindex (1), but that seems in keeping with the rest of the
> synthetic fields.
> 
> Adding this support allows testing BPF that operates differently on
> incoming and outgoing skbs by discriminating on this field.
> 
> Signed-off-by: Neil Spring <ntspring@fb.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>
