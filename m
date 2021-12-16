Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EBB47684E
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 03:48:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhLPCsi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 21:48:38 -0500
Received: from 1.srv.vincent-minet.net ([91.134.209.153]:52564 "EHLO
        1.srv.vincent-minet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbhLPCsi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 21:48:38 -0500
Received: from portablevm.vincent-minet.net (ns3003576.ip-5-196-75.eu [5.196.75.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 1.srv.vincent-minet.net (Postfix) with ESMTPSA id BDEBD60229;
        Thu, 16 Dec 2021 03:16:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=vincent-minet.net;
        s=2017042601; t=1639620974;
        bh=cUpUFzujsf5t/qshF45kersvWqKUQpzmiH5zCoKH4WQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=O+hejwFHf56U2+hV+e1fUFmMFji2V+EV9BlIUHzStiraPZ1gyorgrZUoTz+zi32nr
         3x389gGUldC9XVxPZRGG5c2aQQaJW6ZaVfVRwynV4jrzGTnV515u79C4BCfSzEPZ6W
         mNIeUijmmM9NVOeeh51q+V1Q0gl1kWjE8RfCNvM8=
Date:   Thu, 16 Dec 2021 03:48:34 +0100
From:   Vincent Minet <vincent@vincent-minet.net>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] libbpf: fix typo in btf__dedup@LIBBPF_0.0.2 definition
Message-ID: <YbqpAnxRnEbu1but@localhost.localdomain>
References: <20211210063112.80047-1-vincent@vincent-minet.net>
 <CAEf4BzbRqsi_0fBYK2S-huurKic1X1hDcJYX=0sDCVpvp669gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbRqsi_0fBYK2S-huurKic1X1hDcJYX=0sDCVpvp669gg@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 09, 2021 at 10:48:15PM -0800, Andrii Nakryiko wrote:
>
> How did you run into this problem? Are you using btf__dedup() for
> something? Can you please share some details?
 
I ran into the problem with pahole (built against the shared libbpf).
Nothing more than that.
