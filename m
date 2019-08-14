Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9245A8DBFA
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2019 19:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfHNRfo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Aug 2019 13:35:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39028 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfHNRfo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Aug 2019 13:35:44 -0400
Received: by mail-lf1-f65.google.com with SMTP id x3so26159149lfn.6
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2019 10:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipyg6fauzpsIdl/nnntiD6RmLQTr2+DndPSVDLw5Knc=;
        b=AC91ZFRZOoHN8Eu5C121EBTZkJKombXWjn8AEbPPblnSwvyWEZ1bLcACJ9iaURiarF
         aR2bk8B2YE+OzEX1spUSYTa0eckYU3jZ2YUbzqWVStoxSDCDvJs0iqDnRTfmNrBsrNXh
         QTQwCdrJ82O8/tYTtMNr4h8vs8ncP21lpJ2BiKpfSgFk9bfBwAK4XWZnQzrF7mqJqOEg
         c2Vhkjc86qMck9PUPfu3DmGzze/mtfDf+aL4fHYVKG39QccAPDHHTwZw899e8ALwpoH6
         bZ3986wO2QX3M+pVLJiOgT02Oy58s1NDK5BrbitMJqycPjjk+HkcRGCWGRftbv/e6Q+6
         5UDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipyg6fauzpsIdl/nnntiD6RmLQTr2+DndPSVDLw5Knc=;
        b=jIMlG5Fv00j5wev2v5oPzp0jM3cZLr3Ph4H1KxFZDiWo0UJecj2PWyyzzRJKPXIXEf
         iSPJN9hxtdP8SmnTsoYvdOxN4igiXWJjqUwTu1F9UIeqC7FC90E0rtM3Lbfs1exo3hg/
         M1qigs1XGraX0cRidwa+yKpO7VMW1/b1vDw54jT/rUeP2mgUygF4XmgYpY9YIZbLLFlZ
         xCRt2HB0a+HDglJiX1dYas6TITR3AApmDA7B/8xo9OOZKFSygzBgW4d3mIk+HwnDXZpA
         43ysN50OZ2ya3ugar9NywBQCWrNDWVSE+q54AqA/5XB7rZiVt/scGAYSqaffbSiDbjR4
         JsEA==
X-Gm-Message-State: APjAAAVxBi1l/Qmsi4cEH2Fg/yesntdDh4/T1lHCu3l/13jLL7QM6DIK
        E7wQOcq7ftMzhj+cvYd0F26DdZsu+gXw9/UqBHSgOQ==
X-Google-Smtp-Source: APXvYqzX1EqOTUK32r/nKOezalYcVOG74nUqE8Fd2oajf52nyXIKFH5hwq6/pu2siyEJoXjxDSjCMHktWLYOU09ELY4=
X-Received: by 2002:a19:641a:: with SMTP id y26mr281701lfb.29.1565804141930;
 Wed, 14 Aug 2019 10:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190813162630.124544-1-sdf@google.com> <20190813162630.124544-3-sdf@google.com>
 <20190814172819.syz5skzil2ekdu5g@kafai-mbp>
In-Reply-To: <20190814172819.syz5skzil2ekdu5g@kafai-mbp>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 14 Aug 2019 10:35:30 -0700
Message-ID: <CAKH8qBvjBx21LXbGBDFqO6LVs5w8WO6X70hScyLETUGh4jGkfQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/4] bpf: support cloning sk storage on accept()
To:     Martin Lau <kafai@fb.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 14, 2019 at 10:28 AM Martin Lau <kafai@fb.com> wrote:
>
> On Tue, Aug 13, 2019 at 09:26:28AM -0700, Stanislav Fomichev wrote:
> > Add new helper bpf_sk_storage_clone which optionally clones sk storage
> > and call it from sk_clone_lock.
> Acked-by: Martin KaFai Lau <kafai@fb.com>
Thanks! Will send out a v4 to address Yonghong's and Daniel's suggestions.
