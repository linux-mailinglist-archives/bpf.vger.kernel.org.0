Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C39D5AE83E
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 14:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbiIFMdr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 08:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiIFMdf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 08:33:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE10B2;
        Tue,  6 Sep 2022 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662467613; x=1694003613;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=6XDqX/CSPbavvozuQWLYd8brdVPqYpocNIqP0VMELvc=;
  b=jQuT9ORFqjs/M69hf9wnIz/PPKPxzdXsGNfVSvOfNYdFPZGZxbOjQmp5
   6WuOtv3PtR4zx21goUq7lqHoRuDhXrpNOD6uFTJbjhO382lfWRSYiKGB4
   peeDPwQEUnnUEmmcMqHNvWfBYidDiHDINMaeJzNaRchM5Z9C8LGXFN79Z
   ctlNZIub2IAA/Ne8TXg5XRinWIo9x68xIXIKL273ZQE6n1TRVY1X8/x1m
   ZpePrGP63+BV//I+5R97a68xyfHQ2jIfZSbow0lg5P4MizG+eyeryYgBO
   1Ng2SMnU1iRTlpys+f8/pmAOygpj56FgC+vp7aJ01acrbXnuvoeShx/mw
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="360528670"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="360528670"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:33:11 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="675671308"
Received: from reichelh-mobl.ger.corp.intel.com (HELO localhost) ([10.252.45.69])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 05:33:08 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Donald Hunter <donald.hunter@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Donald Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] Add table of BPF program types to
 libbpf docs
In-Reply-To: <20220829091500.24115-3-donald.hunter@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20220829091500.24115-1-donald.hunter@gmail.com>
 <20220829091500.24115-3-donald.hunter@gmail.com>
Date:   Tue, 06 Sep 2022 15:32:50 +0300
Message-ID: <87h71kadjh.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 29 Aug 2022, Donald Hunter <donald.hunter@gmail.com> wrote:
> Extend the libbpf documentation with a table of program types,
> attach points and ELF section names. This table uses data from
> program_types.csv which is generated from tools/lib/bpf/libbpf.c
> during the documentation build.
>
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  Documentation/Makefile                     |  3 +-
>  Documentation/bpf/libbpf/Makefile          | 49 ++++++++++++++++++++++
>  Documentation/bpf/libbpf/index.rst         |  3 ++
>  Documentation/bpf/libbpf/program_types.rst | 32 ++++++++++++++
>  Documentation/bpf/programs.rst             |  3 ++
>  5 files changed, 89 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/bpf/libbpf/Makefile
>  create mode 100644 Documentation/bpf/libbpf/program_types.rst
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 8a63ef2dcd1c..f007314770e1 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -66,7 +66,8 @@ I18NSPHINXOPTS  =3D $(PAPEROPT_$(PAPER)) $(SPHINXOPTS) .
>  loop_cmd =3D $(echo-cmd) $(cmd_$(1)) || exit;
>=20=20
>  BUILD_SUBDIRS =3D \
> -	Documentation/userspace-api/media
> +	Documentation/userspace-api/media \
> +	Documentation/bpf/libbpf
>=20=20
>  quiet_cmd_build_subdir =3D SUBDIR  $2
>        cmd_build_subdir =3D $(MAKE) BUILDDIR=3D$(abspath $(BUILDDIR)) $(b=
uild)=3D$2 $3
> diff --git a/Documentation/bpf/libbpf/Makefile b/Documentation/bpf/libbpf=
/Makefile
> new file mode 100644
> index 000000000000..b3dc096c4a96
> --- /dev/null
> +++ b/Documentation/bpf/libbpf/Makefile
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Rules to convert BPF program types in tools/lib/bpf/libbpf.c
> +# into a .csv file
> +
> +FILES =3D program_types.csv
> +
> +TARGETS :=3D $(addprefix $(BUILDDIR)/, $(FILES))
> +
> +# Extract program types and properties from the section definitions in l=
ibbpf.c such as
> +# SEC_DEF("socket", SOCKET_FILTER, 0, SEC_NONE) to generate program_type=
s.csv
> +#
> +# Here is a sample of the generated output that includes .rst formatting:
> +#
> +#  Program Type,Attach Type,ELF Section Name,Sleepable
> +#  ``BPF_PROG_TYPE_SOCKET_FILTER``,,``socket``,
> +#  ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT_OR_MIGRATE``=
,``sk_reuseport/migrate``,
> +#  ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT``,``sk_reuse=
port``,
> +#  ``BPF_PROG_TYPE_KPROBE``,,``kprobe+``,
> +#  ``BPF_PROG_TYPE_KPROBE``,,``uprobe+``,
> +#  ``BPF_PROG_TYPE_KPROBE``,,``uprobe.s+``,Yes
> +
> +$(BUILDDIR)/program_types.csv:	$(srctree)/tools/lib/bpf/libbpf.c
> +	$(Q)awk -F'[",[:space:]]+' \
> +	'BEGIN { print "Program Type,Attach Type,ELF Section Name,Sleepable" } \
> +	/SEC_DEF\(\"/ && !/SEC_DEPRECATED/ { \
> +	type =3D "``BPF_PROG_TYPE_" $$4 "``"; \
> +	attach =3D index($$5, "0") ? "" : "``" $$5 "``"; \
> +	section =3D "``" $$3 "``"; \
> +	sleepable =3D index($$0, "SEC_SLEEPABLE") ? "Yes" : ""; \
> +	print type "," attach "," section "," sleepable }' \
> +	$< > $@
> +
> +.PHONY: all html epub xml latex linkcheck clean
> +
> +all: $(BUILDDIR) ${TARGETS}
> +	@:
> +
> +html: all
> +epub: all
> +xml: all
> +latex: all
> +linkcheck:
> +
> +clean:
> +	-$(Q)rm -f ${TARGETS} 2>/dev/null
> +
> +$(BUILDDIR):
> +	$(Q)mkdir -p $@
> diff --git a/Documentation/bpf/libbpf/index.rst b/Documentation/bpf/libbp=
f/index.rst
> index 3722537d1384..f9b3b252e28f 100644
> --- a/Documentation/bpf/libbpf/index.rst
> +++ b/Documentation/bpf/libbpf/index.rst
> @@ -1,5 +1,7 @@
>  .. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>=20=20
> +.. _libbpf:
> +
>  libbpf
>  =3D=3D=3D=3D=3D=3D
>=20=20
> @@ -7,6 +9,7 @@ libbpf
>     :maxdepth: 1
>=20=20
>     API Documentation <https://libbpf.readthedocs.io/en/latest/api.html>
> +   program_types
>     libbpf_naming_convention
>     libbpf_build
>=20=20
> diff --git a/Documentation/bpf/libbpf/program_types.rst b/Documentation/b=
pf/libbpf/program_types.rst
> new file mode 100644
> index 000000000000..04fbb48b8a6a
> --- /dev/null
> +++ b/Documentation/bpf/libbpf/program_types.rst
> @@ -0,0 +1,32 @@
> +.. SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +
> +.. _program_types_and_elf:
> +
> +Program Types and ELF Sections
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +The table below lists the program types, their attach types where releva=
nt and the ELF section
> +names supported by libbpf for them. The ELF section names follow these r=
ules:
> +
> +- ``type`` is an exact match, e.g. ``SEC("socket")``
> +- ``type+`` means it can be either exact ``SEC("type")`` or well-formed =
``SEC("type/extras")``
> +  with a =E2=80=98``/``=E2=80=99 separator between ``type`` and ``extras=
``.
> +
> +When ``extras`` are specified, they provide details of how to auto-attac=
h the BPF program.
> +The format of ``extras`` depends on the program type, e.g. ``SEC("tracep=
oint/<category>/<name>")``
> +for tracepoints or ``SEC("usdt/<path-to-binary>:<usdt_provider>:<usdt_na=
me>")`` for USDT probes.
> +
> +..
> +  program_types.csv is generated from tools/lib/bpf/libbpf.c and is foma=
tted like this:
> +    Program Type,Attach Type,ELF Section Name,Sleepable
> +    ``BPF_PROG_TYPE_SOCKET_FILTER``,,``socket``,
> +    ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT_OR_MIGRATE`=
`,``sk_reuseport/migrate``,
> +    ``BPF_PROG_TYPE_SK_REUSEPORT``,``BPF_SK_REUSEPORT_SELECT``,``sk_reus=
eport``,
> +    ``BPF_PROG_TYPE_KPROBE``,,``kprobe+``,
> +    ``BPF_PROG_TYPE_KPROBE``,,``uprobe+``,
> +    ``BPF_PROG_TYPE_KPROBE``,,``uprobe.s+``,Yes
> +
> +.. csv-table:: Program Types and Their ELF Section Names
> +   :file: ../../output/program_types.csv

Oh. You should probably test this with out-of-tree builds.

BR,
Jani.

> +   :widths: 40 30 20 10
> +   :header-rows: 1
> diff --git a/Documentation/bpf/programs.rst b/Documentation/bpf/programs.=
rst
> index 620eb667ac7a..c99000ab6d9b 100644
> --- a/Documentation/bpf/programs.rst
> +++ b/Documentation/bpf/programs.rst
> @@ -7,3 +7,6 @@ Program Types
>     :glob:
>=20=20
>     prog_*
> +
> +For a list of all program types, see :ref:`program_types_and_elf` in
> +the :ref:`libbpf` documentation.

--=20
Jani Nikula, Intel Open Source Graphics Center
