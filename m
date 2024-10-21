Return-Path: <bpf+bounces-42600-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B559A6538
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 12:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01C901C22295
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 10:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623A91E5722;
	Mon, 21 Oct 2024 10:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcqRLLFu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA981E25E3;
	Mon, 21 Oct 2024 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507769; cv=none; b=lzY/8GwiE6UQBtLvhQXNFXX1ITqI5GqfvKNuhPxG/wqwipakJaPRbQvYKI8UlPX4Urb2CI654vg5XGkIEUnU5eh4W4ugMhkCIEWYWcK2+9P9CqFPc1HKMstMPjV8GdNnlwnCrZFAY7HsDHThQf5Qtkj3BJfwL45fKwZlUhQNIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507769; c=relaxed/simple;
	bh=PWuT/EOBimTOEiqx2KtwNUDrZPZJNrPZWj21C0U9vdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5lynwwyNxW1hsvP1Bhsd7IGVIofHeQdSIAiToSrcf2NF4rmp8l/o0iLsZVN0DoBHlAMbPO142Jnv4jbQlvKaCYzZNylxJsv7dDrpyIH3zBUO7yR3kdgBbTmnPgej0phJq3V6gfEPAI2s13r0YIM9/wolsW3LrsuKiqk3KeXVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bcqRLLFu; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea0ff74b15so2718683a12.3;
        Mon, 21 Oct 2024 03:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729507767; x=1730112567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JmtK7nXd2NsXVObzbe0Gmee0U5Xtss6J87a3VoybBDA=;
        b=bcqRLLFuFVP6soV/qvTAY8M8AJ23sEssHFwG9G0n+Y+UkBZGm50EYj4YwHStPrXI6z
         G/GIrBD69LBNao4vGDo3bYVvwI8M41AEr7PbjGfJxSOkXMxLOMbhYLIUcPLb3EggunVu
         NQ63UhJmZYtie/ouhr4TBA3RQFePMECyubQ77cPm/6Af2xX8YcZRt8+Iu+GjHzYQaw8C
         FlN9qKV2waVRcFTl2kyo2ZDTquHlSMPqbm+v801cizacpSq5wvc+iwCn7ztK2Y1N/C+c
         PDS46xS0jksuMcpdkw6Q+3l0nO99x0m4rYmXkQa3sWWccUFwiBhZmVKIFKKrCRHlEhK8
         CloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729507767; x=1730112567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmtK7nXd2NsXVObzbe0Gmee0U5Xtss6J87a3VoybBDA=;
        b=FHCYHnsETIdf1isrBFL6fIntnuee43957MLzu2JmnFQfnV0ELdh9sM4piO6dz1VZmg
         g8mz72MTghvSLiAD5OOslX1iDwXmUxFud6/9YxaAfQbgoQIS4aEx8f32PU/ZCh/DhmZ1
         noWlHSuYATeNTWqudVZZLwkwBB9eF9Hh30WOaTjriWZ25BuBVZak07kyVWorl6/rb31s
         wrcW1q00STXzcMkcs5IjduxJxwEBhDwU+h+NT0gxdNbbNBtfUqLrX05cBiACyUjW8Guc
         koygbTYnWUXTTzbw5nnypZTssZXeTA7XX3Op/OmLptcnB90ugS8lmwnHf/BcyjEI8BRk
         i6ag==
X-Forwarded-Encrypted: i=1; AJvYcCUcyG5wKd7CXF9SRzvuBWq4oLCvzFOLlyQoUcj10SYHFQ3BVrdWQG+Ct/gxGTg1t6rGMsTK+4MQ@vger.kernel.org, AJvYcCUsazaB7GjBLcZEW/OhUVchEJdP8f+eTa+miL5VpWYB/kLFXsFovcfk3fmNHzCJWf9v9cs=@vger.kernel.org, AJvYcCXNRnBpz2OTLMmXUJsUk+SYtNUdpVQ+7WjHPapWu1KD9ULW2bF/FK7AtJyZTYl+90joODUiWvWkQ83ZTqoC@vger.kernel.org, AJvYcCXik5t98DsZTqrDL5mwieIttsItrM3W6xa0w8mFM21oTc6n9wJ7sLozJA6k5PA9lhebmyiGIq1TBZcm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1+A/NTW/EDNH+mbHLsrutz7EJO22sDXXh8NfAAsJRv7hFD00C
	apBk+IehfTERu/EpNUcbTx1rct+Zg+aKXiJ6Ee9zgqebzU0KJupn
X-Google-Smtp-Source: AGHT+IE1kJxSsXPr6pw6JUJL1sjWmrzw+HxWh/rC5wOTwD8VLS7hm5DnGO07zWpGVBbBdPy2gjtDtg==
X-Received: by 2002:a05:6a21:1693:b0:1d8:a49b:ee71 with SMTP id adf61e73a8af0-1d92c51e66dmr16878807637.29.1729507766535;
        Mon, 21 Oct 2024 03:49:26 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1356c67sm2639165b3a.95.2024.10.21.03.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 03:49:25 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9FAD94396293; Mon, 21 Oct 2024 17:49:14 +0700 (WIB)
Date: Mon, 21 Oct 2024 17:49:14 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Joe Damato <jdamato@fastly.com>,
	Linux Networking <netdev@vger.kernel.org>
Cc: namangulati@google.com, edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v2 6/6] docs: networking: Describe irq suspension
Message-ID: <ZxYxqhj7cesDO8-j@archie.me>
References: <20241021015311.95468-1-jdamato@fastly.com>
 <20241021015311.95468-7-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4eKdL+7Mj1Y2J0FB"
Content-Disposition: inline
In-Reply-To: <20241021015311.95468-7-jdamato@fastly.com>


--4eKdL+7Mj1Y2J0FB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 01:53:01AM +0000, Joe Damato wrote:
> diff --git a/Documentation/networking/napi.rst b/Documentation/networking=
/napi.rst
> index dfa5d549be9c..3b43477a52ce 100644
> --- a/Documentation/networking/napi.rst
> +++ b/Documentation/networking/napi.rst
> @@ -192,6 +192,28 @@ is reused to control the delay of the timer, while
>  ``napi_defer_hard_irqs`` controls the number of consecutive empty polls
>  before NAPI gives up and goes back to using hardware IRQs.
> =20
> +The above parameters can also be set on a per-NAPI basis using netlink v=
ia
> +netdev-genl. This can be done programmatically in a user application or =
by
> +using a script included in the kernel source tree: ``tools/net/ynl/cli.p=
y``.
> +
> +For example, using the script:
> +
> +.. code-block:: bash
> +
> +  $ kernel-source/tools/net/ynl/cli.py \
> +            --spec Documentation/netlink/specs/netdev.yaml \
> +            --do napi-set \
> +            --json=3D'{"id": 345,
> +                     "defer-hard-irqs": 111,
> +                     "gro-flush-timeout": 11111}'
> +
> +Similarly, the parameter ``irq-suspend-timeout`` can be set using netlink
> +via netdev-genl. There is no global sysfs parameter for this value.

In JSON, both gro-flush-timeout and irq-suspend-timeout parameter
names are written in hyphens; but the rest of the docs uses underscores
(that is, gro_flush_timeout and irq_suspend_timeout), right?

> +
> +``irq_suspend_timeout`` is used to determine how long an application can
> +completely suspend IRQs. It is used in combination with SO_PREFER_BUSY_P=
OLL,
> +which can be set on a per-epoll context basis with ``EPIOCSPARAMS`` ioct=
l.
> +
>  .. _poll:
> =20
>  Busy polling
> @@ -207,6 +229,46 @@ selected sockets or using the global ``net.core.busy=
_poll`` and
>  ``net.core.busy_read`` sysctls. An io_uring API for NAPI busy polling
>  also exists.
> =20
> +epoll-based busy polling
> +------------------------
> +
> +It is possible to trigger packet processing directly from calls to
> +``epoll_wait``. In order to use this feature, a user application must en=
sure
> +all file descriptors which are added to an epoll context have the same N=
API ID.
> +
> +If the application uses a dedicated acceptor thread, the application can=
 obtain
> +the NAPI ID of the incoming connection using SO_INCOMING_NAPI_ID and then
> +distribute that file descriptor to a worker thread. The worker thread wo=
uld add
> +the file descriptor to its epoll context. This would ensure each worker =
thread
> +has an epoll context with FDs that have the same NAPI ID.
> +
> +Alternatively, if the application uses SO_REUSEPORT, a bpf or ebpf progr=
am be
> +inserted to distribute incoming connections to threads such that each th=
read is
> +only given incoming connections with the same NAPI ID. Care must be take=
n to
> +carefully handle cases where a system may have multiple NICs.
> +
> +In order to enable busy polling, there are two choices:
> +
> +1. ``/proc/sys/net/core/busy_poll`` can be set with a time in useconds t=
o busy
> +   loop waiting for events. This is a system-wide setting and will cause=
 all
> +   epoll-based applications to busy poll when they call epoll_wait. This=
 may
> +   not be desirable as many applications may not have the need to busy p=
oll.
> +
> +2. Applications using recent kernels can issue an ioctl on the epoll con=
text
> +   file descriptor to set (``EPIOCSPARAMS``) or get (``EPIOCGPARAMS``) `=
`struct
> +   epoll_params``:, which user programs can define as follows:
> +
> +.. code-block:: c
> +
> +  struct epoll_params {
> +      uint32_t busy_poll_usecs;
> +      uint16_t busy_poll_budget;
> +      uint8_t prefer_busy_poll;
> +
> +      /* pad the struct to a multiple of 64bits */
> +      uint8_t __pad;
> +  };
> +
>  IRQ mitigation
>  ---------------
> =20
> @@ -222,12 +284,78 @@ Such applications can pledge to the kernel that the=
y will perform a busy
>  polling operation periodically, and the driver should keep the device IR=
Qs
>  permanently masked. This mode is enabled by using the ``SO_PREFER_BUSY_P=
OLL``
>  socket option. To avoid system misbehavior the pledge is revoked
> -if ``gro_flush_timeout`` passes without any busy poll call.
> +if ``gro_flush_timeout`` passes without any busy poll call. For epoll-ba=
sed
> +busy polling applications, the ``prefer_busy_poll`` field of ``struct
> +epoll_params`` can be set to 1 and the ``EPIOCSPARAMS`` ioctl can be iss=
ued to
> +enable this mode. See the above section for more details.
> =20
>  The NAPI budget for busy polling is lower than the default (which makes
>  sense given the low latency intention of normal busy polling). This is
>  not the case with IRQ mitigation, however, so the budget can be adjusted
> -with the ``SO_BUSY_POLL_BUDGET`` socket option.
> +with the ``SO_BUSY_POLL_BUDGET`` socket option. For epoll-based busy pol=
ling
> +applications, the ``busy_poll_budget`` field can be adjusted to the desi=
red value
> +in ``struct epoll_params`` and set on a specific epoll context using the=
 ``EPIOCSPARAMS``
> +ioctl. See the above section for more details.
> +
> +It is important to note that choosing a large value for ``gro_flush_time=
out``
> +will defer IRQs to allow for better batch processing, but will induce la=
tency
> +when the system is not fully loaded. Choosing a small value for
> +``gro_flush_timeout`` can cause interference of the user application whi=
ch is
> +attempting to busy poll by device IRQs and softirq processing. This value
> +should be chosen carefully with these tradeoffs in mind. epoll-based busy
> +polling applications may be able to mitigate how much user processing ha=
ppens
> +by choosing an appropriate value for ``maxevents``.
> +
> +Users may want to consider an alternate approach, IRQ suspension, to hel=
p deal
> +with these tradeoffs.
> +
> +IRQ suspension
> +--------------
> +
> +IRQ suspension is a mechanism wherein device IRQs are masked while epoll
> +triggers NAPI packet processing.
> +
> +While application calls to epoll_wait successfully retrieve events, the =
kernel will
> +defer the IRQ suspension timer. If the kernel does not retrieve any even=
ts
> +while busy polling (for example, because network traffic levels subsided=
), IRQ
> +suspension is disabled and the IRQ mitigation strategies described above=
 are
> +engaged.
> +
> +This allows users to balance CPU consumption with network processing
> +efficiency.
> +
> +To use this mechanism:
> +
> +  1. The per-NAPI config parameter ``irq_suspend_timeout`` should be set=
 to the
> +     maximum time (in nanoseconds) the application can have its IRQs
> +     suspended. This is done using netlink, as described above. This tim=
eout
> +     serves as a safety mechanism to restart IRQ driver interrupt proces=
sing if
> +     the application has stalled. This value should be chosen so that it=
 covers
> +     the amount of time the user application needs to process data from =
its
> +     call to epoll_wait, noting that applications can control how much d=
ata
> +     they retrieve by setting ``max_events`` when calling epoll_wait.
> +
> +  2. The sysfs parameter or per-NAPI config parameters ``gro_flush_timeo=
ut``
> +     and ``napi_defer_hard_irqs`` can be set to low values. They will be=
 used
> +     to defer IRQs after busy poll has found no data.
> +
> +  3. The ``prefer_busy_poll`` flag must be set to true. This can be done=
 using
> +     the ``EPIOCSPARAMS`` ioctl as described above.
> +
> +  4. The application uses epoll as described above to trigger NAPI packet
> +     processing.
> +
> +As mentioned above, as long as subsequent calls to epoll_wait return eve=
nts to
> +userland, the ``irq_suspend_timeout`` is deferred and IRQs are disabled.=
 This
> +allows the application to process data without interference.
> +
> +Once a call to epoll_wait results in no events being found, IRQ suspensi=
on is
> +automatically disabled and the ``gro_flush_timeout`` and
> +``napi_defer_hard_irqs`` mitigation mechanisms take over.
> +
> +It is expected that ``irq_suspend_timeout`` will be set to a value much =
larger
> +than ``gro_flush_timeout`` as ``irq_suspend_timeout`` should suspend IRQ=
s for
> +the duration of one userland processing cycle.
> =20
>  .. _threaded:
> =20

The rest LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--4eKdL+7Mj1Y2J0FB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZxYxpgAKCRD2uYlJVVFO
o4lTAQCnsX7vOVwY7dZtmC2jjn4DgXJVZou/YivEqUq9WxeEYgEAgKJAP8f9zHn5
DlOmCbNw84sIZGNDZEAZ4HW/LwspuQw=
=r7XE
-----END PGP SIGNATURE-----

--4eKdL+7Mj1Y2J0FB--

