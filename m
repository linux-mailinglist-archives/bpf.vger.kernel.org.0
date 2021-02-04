Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B94B30E91B
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 02:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbhBDBBY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 20:01:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:41536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233575AbhBDBBW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 20:01:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F3B364F55;
        Thu,  4 Feb 2021 01:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612400441;
        bh=smBp8AnOVVzwODUEAWjwK0XVQziFJjFk6acz4Wq0qRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i1I+izSK3BQpzHF5pa9ly4kTNQZxYfVN5Fd1+hXXG9ZHNZyxlETvZ3Hp7TUS1o3H0
         x5VES+9bQgpTMzroXG0g0Yb4igWR3cI3TMioeTn4OZl/B58nvuU1a3oYlbocPyWXGZ
         fFbfTAZ1PmdDI2HV+V6NuuQVwTj2sBvV/6PV9mRxYUTGuFPcbB6EqDIKJB2hzWKKDY
         VeJ1/uBqF+yS+48bHAERB4txfxzp755Nb8zbcZeP9gyllz1aM0bAhIWiuabsXoWiZb
         lm/USizoeqpQrpkgkO4cwrmFJaU0J30A46Tjo7uMtw76mamlG1F5OR+G1vUNGLHUVj
         lG5vdaNqT3OlA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E64A640513; Wed,  3 Feb 2021 22:00:38 -0300 (-03)
Date:   Wed, 3 Feb 2021 22:00:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: 5:11: in-kernel BTF is malformed
Message-ID: <20210204010038.GA854763@kernel.org>
References: <CAJCQCtSQLc0VHqO4BY_-YB2OmCNNmHCS6fNdQKmMWGn2v=Jpdw@mail.gmail.com>
 <CAJCQCtRHOidM7Vps1JQSpZA14u+B5fR860FwZB=eb1wYjTpqDw@mail.gmail.com>
 <CAEf4BzZ4oTB0-JizHe1VaCk2V+Jb9jJoTznkgh6CjE5VxNVqbg@mail.gmail.com>
 <CAJCQCtRw6UWGGvjn0x__godYKYQXXmtyQys4efW2Pb84Q5q8Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJCQCtRw6UWGGvjn0x__godYKYQXXmtyQys4efW2Pb84Q5q8Eg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 03, 2021 at 05:46:48PM -0700, Chris Murphy escreveu:
> This is just the vmlinuz-5.11.0-0.rc6.141.fc34.x86_64 file
> 
> https://drive.google.com/file/d/1G_2qLVRIy-ExaJI1-cTqDssrDu3sWo-m/view?usp=sharing

Can you please provide the vmlinux for this file as well?

- Arnaldo
