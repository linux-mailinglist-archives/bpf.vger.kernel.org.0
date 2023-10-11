Return-Path: <bpf+bounces-11916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C637C55C8
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 15:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB0D282535
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 13:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DDE200AF;
	Wed, 11 Oct 2023 13:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaYYuqYF"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F8C1F945
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 13:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1110CC433C7;
	Wed, 11 Oct 2023 13:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697031946;
	bh=hhI2du2wdG1ZY2MdeHOhI6DDrpzvKP3LvQCKE392xJg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=SaYYuqYFP2AOsilXmF5SGSllEYKKJ4n+/i+eRhcqtHv5dY3vSDG2fbiSqQUKdnRt6
	 vp+Hf8EZ6CoUuceUdziJExGqgSMVaE9wXqZHHGiVrYpiacD+fhHyWZXEuP7gS/7tZu
	 /cfJTQFm7+wUykCQQDhpDqtESbYSXKkT1W148h5OgxDSd4kKpPE8+O+w8ggFB3HOG3
	 QRw/kSFB4n1eBcGBhoXAu08J/D0Z0rlmmDPoaMhP0Cs8ez9jpwGgNlcTKTmtRrzNaU
	 SCoM9PF+FlDZAp6oRimfRuOJMFTpNNxAyEF8Ss4V/9umLBx73q9+XYuBQBZOJp7dqv
	 6kV3H6GNvOICw==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Justin Stitt <justinstitt@google.com>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
References: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
Subject: Re: [PATCH v3 0/3] selftests/hid: assorted fixes
Message-Id: <169703194378.3126081.13251971976785038026.b4-ty@kernel.org>
Date: Wed, 11 Oct 2023 15:45:43 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1

On Thu, 05 Oct 2023 17:55:31 +0200, Benjamin Tissoires wrote:
> And this is the last(?) revision of this series which should now compile
> with or without CONFIG_HID_BPF set.
> 
> I had to do changes because [1] was failing
> 
> Nick, I kept your Tested-by, even if I made small changes in 1/3. Feel
> free to shout if you don't want me to keep it.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.7/selftests), thanks!

[1/3] selftests/hid: ensure we can compile the tests on kernels pre-6.3
      https://git.kernel.org/hid/hid/c/ae7487d112cf
[2/3] selftests/hid: do not manually call headers_install
      https://git.kernel.org/hid/hid/c/89d024a7ba02
[3/3] selftests/hid: force using our compiled libbpf headers
      https://git.kernel.org/hid/hid/c/91939636cac4

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>


