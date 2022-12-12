Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480C0649857
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 05:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiLLEBw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Dec 2022 23:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiLLEBt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Dec 2022 23:01:49 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12388D2C2;
        Sun, 11 Dec 2022 20:01:48 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so14256192pjp.1;
        Sun, 11 Dec 2022 20:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xRsAixLtebSGlz9qxMtCs1lxtuRGn9wkDScMhyWslEM=;
        b=mBxd5qc4zScGoF2xvZaoTkwPWn0pYYhHyWiN3xxAV4jO4uiwMu2DhQ8h8gnMYCR4Po
         nBPR1a9ah2UlbnuOq2qmzr5r7dyrbu+fS4iWfFEbghpZRUFX2ohF+Roqj9yNa1axySHn
         cuHQb7dB5XCX2xAxk+EZAZS8SdeygyWIgrsjtOpA5yg4egzU2kdFNmimmhvyUCmTJbli
         CRow2MfrxOOLZBnlgfmSOwszHU1/TgoYuY4dne9hSRS7uXQzPs/TW1w76t/NLq4sN4PF
         DQSZM2x4zHarlCOax059E3o86u+uW8aGTTmBysN4HFUJho5YiOQ0s4uJ0UyG4GdTkh3h
         XjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRsAixLtebSGlz9qxMtCs1lxtuRGn9wkDScMhyWslEM=;
        b=Pgr82+nfT6Mdm1DOJtvkU6MIHG/p5KFrfQ56ar1IhhVUNlxYB9Bbix7sJslL37H9l8
         yHIrV6s0oMAGyyUuLKO1QPCcRrtkK+T1PRkdE1h/Y/o4khAo4EDK3QV412uhHWrdzanf
         b7aebUyMILApjRWyvNvVvfN3EDqhYyODPlnbLg3/XmKu7KlnyKb69zAAuynLptG2rlWC
         qw9+cSDfc45PbxtRE9YI1J9QavaXHgy4/2WhFs7hrBvBMyHfpS68eJvNbYthqQ6V8nFk
         NrlBOEmRbSIk1UVla2YpIhakXIuB9+WL65uC0Rh9vzCbR8q4c62LrI3pq4EzcXX0jK/B
         HudA==
X-Gm-Message-State: ANoB5pnXTbTsogZQ+JM7gzBzmhoFR0t93ljQwMRXaCDJ81dxaoRCb2kA
        OgKeEXooAo+FMnwqnp0+gvo=
X-Google-Smtp-Source: AA0mqf5nL18Rr8n4pP3wb+BeHQWYSRa7DA7m6cH+6Rl7UawaLQMXaZ0VrsdkV0CgqVOQXzQBDmnGFg==
X-Received: by 2002:a17:902:e5c5:b0:189:f69d:d5f7 with SMTP id u5-20020a170902e5c500b00189f69dd5f7mr22092720plf.57.1670817707441;
        Sun, 11 Dec 2022 20:01:47 -0800 (PST)
Received: from debian.me (subs03-180-214-233-83.three.co.id. [180.214.233.83])
        by smtp.gmail.com with ESMTPSA id x3-20020a1709029a4300b00189db296776sm5096336plv.17.2022.12.11.20.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 20:01:46 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id DA919103E00; Mon, 12 Dec 2022 11:01:42 +0700 (WIB)
Date:   Mon, 12 Dec 2022 11:01:42 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 28/31] sched_ext: Add
 Documentation/scheduler/sched-ext.rst
Message-ID: <Y5anpn997mR2g8Ur@debian.me>
References: <20221130082313.3241517-1-tj@kernel.org>
 <20221130082313.3241517-29-tj@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NkrJJWLHASFJeCbl"
Content-Disposition: inline
In-Reply-To: <20221130082313.3241517-29-tj@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--NkrJJWLHASFJeCbl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 29, 2022 at 10:23:10PM -1000, Tejun Heo wrote:
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: David Vernet <dvernet@meta.com>
> Acked-by: Josh Don <joshdon@google.com>
> Acked-by: Hao Luo <haoluo@google.com>
> Acked-by: Barret Rhoden <brho@google.com>

No patch description? Really? Please write one.

For patch subject, better write "Documentation: scheduler: document
extensible scheduler class".

> +* The system integrity is maintained no matter what the BPF scheduler do=
es.
> +  The default scheduling behavior is restored anytime an error is detect=
ed,
> +  a runnable task stalls, or on sysrq-S.
> +
> <snipped>...
> +Terminating the sched_ext scheduler program, triggering sysrq-S, or
> +detection of any internal error including stalled runnable tasks aborts =
the
> +BPF scheduler and reverts all tasks back to CFS.

IMO the reference to SysRq key can be reworded:

---- >8 ----
diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/schedule=
r/sched-ext.rst
index a2ad963b227a1b..404b820119b4a4 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -15,7 +15,8 @@ programs - the BPF scheduler.
=20
 * The system integrity is maintained no matter what the BPF scheduler does.
   The default scheduling behavior is restored anytime an error is detected,
-  a runnable task stalls, or on sysrq-S.
+  a runnable task stalls, or on invoking SysRq key sequence like
+  :kbd:`SysRq-s`.
=20
 Switching to and from sched_ext
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
@@ -35,7 +36,7 @@ case, all ``SCHED_NORMAL``, ``SCHED_BATCH``, ``SCHED_IDLE=
`` and
 ``SCHED_EXT`` tasks are scheduled by sched_ext. In the example schedulers,
 this mode can be selected with the ``-a`` option.
=20
-Terminating the sched_ext scheduler program, triggering sysrq-S, or
+Terminating the sched_ext scheduler program, triggering SysRq key, or
 detection of any internal error including stalled runnable tasks aborts the
 BPF scheduler and reverts all tasks back to CFS.
=20

> +A task is always *dispatch*ed to a dsq for execution. The task starts
> +execution when a CPU *consume*s the task from the dsq.

Sphinx reported two warnings:

Documentation/scheduler/sched-ext.rst:117: WARNING: Inline emphasis start-s=
tring without end-string.
Documentation/scheduler/sched-ext.rst:117: WARNING: Inline emphasis start-s=
tring without end-string.

I have to replace with quotes (since "dispatch" and "consume" have different
meaning in this context):

---- >8 ----
diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/schedule=
r/sched-ext.rst
index 81f78e05a6c214..a2ad963b227a1b 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -114,8 +114,8 @@ there is one global FIFO (``SCX_DSQ_GLOBAL``), and one =
local dsq per CPU
 (``SCX_DSQ_LOCAL``). The BPF scheduler can manage an arbitrary number of
 dsq's using ``scx_bpf_create_dsq()`` and ``scx_bpf_destroy_dsq()``.
=20
-A task is always *dispatch*ed to a dsq for execution. The task starts
-execution when a CPU *consume*s the task from the dsq.
+A task is always "dispatched" to a dsq for execution. The task starts
+execution when a CPU "consumes" the task from the dsq.
=20
 Internally, a CPU only executes tasks which are running on its local dsq,
 and the ``.consume()`` operation is in fact a transfer of a task from a

Otherwise the doc LGTM.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--NkrJJWLHASFJeCbl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5anoAAKCRD2uYlJVVFO
o4naAQDW4OsxpyXFkSZZa/FPiPIiee7bzO9NrpRW8kp2F2ZwHgD/VP8ULdl3iVrY
3IxrZbBf8uTv4n/3QhsmBjuZIc9MlAU=
=/6X2
-----END PGP SIGNATURE-----

--NkrJJWLHASFJeCbl--
