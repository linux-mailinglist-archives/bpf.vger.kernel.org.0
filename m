Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 963CDFDE91
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2019 14:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfKONId (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Nov 2019 08:08:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48579 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727272AbfKONId (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 Nov 2019 08:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573823312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KW+xlZ6QqPnF9SFtAP1nA7oVn9LBMs9V9zow8jCuZq4=;
        b=Ay1Js3rFfKHuen8SiQWgzdE9ALWYLEHDLXN3RnSsRcexpEaN9zQDbgPgE3No8Gf2hZCY53
        mEBwkIEGkQwXR5YzxGjP4BLCdo2oyEg5DygU19pWKBirhUqOIl/H8L/G3efHz/0+dZAjgz
        0EiE6GfoIkQDRUre1HOPIFa7TtiuNT8=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-1gC0tZNzN9WKex6XJmUERg-1; Fri, 15 Nov 2019 08:08:28 -0500
Received: by mail-lj1-f199.google.com with SMTP id l12so1531841lji.10
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2019 05:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KW+xlZ6QqPnF9SFtAP1nA7oVn9LBMs9V9zow8jCuZq4=;
        b=IZLs9531ZfuxrVm0nlSft5WHerjI8XedvORQPd9tsSFntKO04DErwp9e7ZAQuWqtP2
         bz5OLSakEAUZpM5bR+207wlZ9qqd3vBo0swS0QyLFlFkesiS0Q/L5lHUa8V2szIbG+Pi
         Dxxtyi1agJ24BpG93dVi0sN3DVF6J0+ez6sZPXQ5ppnyHoTPa7Lf4nCkyPIGD5Hdy2kp
         h7KyUwGutPPfZqtMCWpcbCmyzy4bDB3fM4vBl1qHPCTR4wXLMeqlmFc5Rtw3D44bIWYG
         taHC2+nHF8gHATo2fEr/NJ2DCnm368TbRzpQ3zjADIcNdm92JXKXy94FB45WIXzs959J
         1zng==
X-Gm-Message-State: APjAAAWHSYKmzC0QjP8nMa8ahXg6b7fLr+6dFyKxV0OFIbB4mcTRCPqi
        jSG8KcZr7u8MxhgxlqJ8C9z70s+Ja8+HDJmjgaJo4C1hctNOswbqd7vvaKDSdRn7A8Sq6W32UlM
        kKZ3Ah7aLkzIl
X-Received: by 2002:a2e:89c6:: with SMTP id c6mr11119753ljk.113.1573823307322;
        Fri, 15 Nov 2019 05:08:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqxI8DX59s339AnvIwBuBVsMr4K/TAtr4akIkMiTg5sDXZ5phUu2Uclj3KqPEczIcx1goPPiyw==
X-Received: by 2002:a2e:89c6:: with SMTP id c6mr11119737ljk.113.1573823307169;
        Fri, 15 Nov 2019 05:08:27 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id v203sm4433066lfa.25.2019.11.15.05.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 05:08:26 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9083F1818C5; Fri, 15 Nov 2019 14:08:25 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jiri Benc <jbenc@redhat.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH bpf] selftests: bpf: xdping is not meant to be run standalone
In-Reply-To: <4365c81198f62521344c2215909634407184387e.1573821726.git.jbenc@redhat.com>
References: <4365c81198f62521344c2215909634407184387e.1573821726.git.jbenc@redhat.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 15 Nov 2019 14:08:25 +0100
Message-ID: <87a78xmgmu.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 1gC0tZNzN9WKex6XJmUERg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jiri Benc <jbenc@redhat.com> writes:

> The actual test to run is test_xdping.sh, which is already in TEST_PROGS.
> The xdping program alone is not runnable with 'make run_tests', it
> immediatelly fails due to missing arguments.
>
> Move xdping to TEST_GEN_PROGS_EXTENDED in order to be built but not run.
>
> Fixes: cd5385029f1d ("selftests/bpf: measure RTT from xdp using xdping")
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Jiri Benc <jbenc@redhat.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

