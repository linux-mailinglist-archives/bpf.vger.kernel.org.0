Return-Path: <bpf+bounces-7467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CF777E84
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 18:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC59E2822C0
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3895120F88;
	Thu, 10 Aug 2023 16:43:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1EB1E1DC;
	Thu, 10 Aug 2023 16:43:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B58D10C4;
	Thu, 10 Aug 2023 09:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691685808; x=1723221808;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=r7+pRLOhmCU2mY1+yp43/cT6YSLlci8CmLi2j4cMZDM=;
  b=a7b4p0prZDMNt18PH5rRzljbNrrJfQGyyvuROzBm1LFttHstKjunoOdt
   hoNWUhvQeuyuceWq/n5VRdm8v4l/7yvODAVrLkVHsfKS0ZhVpfaoRq83h
   CbnfcgRMgPdMx/ib1NTPnGzROBUhNifxXn9hCu5L9p9hYxA1SrXM16f2W
   vsGWEXBuhoBq3BO+2C9nj1TgJi++vgjwjQVKD05O1dR/r7ZORBbMScnyL
   tZV+L9IhtFngAvRhdk94a0ksFG6bKfqcYWTFnuWpPhTM0X5aByhKa6Uex
   HvlCyk9xMf8aRjg4x4+Fi3a13wze2fzI2AyIHWhlJOT7iUUoxxGrTOnYv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351776957"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="351776957"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 09:36:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="855987630"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="855987630"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 10 Aug 2023 09:36:15 -0700
Received: from tphi-mobl.amr.corp.intel.com (tphi-mobl.amr.corp.intel.com [10.209.57.169])
	by linux.intel.com (Postfix) with ESMTP id 47411580AFF;
	Thu, 10 Aug 2023 09:36:15 -0700 (PDT)
Message-ID: <b14b087d8905297504dde89920d8d0a67b7544e8.camel@linux.intel.com>
Subject: Re: [PATCH net-next v2 1/5] platform/x86: intel_pmc_core: Add IPC
 mailbox accessor function and add SoC register access
From: "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To: Hans de Goede <hdegoede@redhat.com>, Choong Yong Liang
 <yong.liang.choong@linux.intel.com>, Rajneesh Bhardwaj
 <irenic.rajneesh@gmail.com>, Mark Gross <markgross@kernel.org>, Jose Abreu
 <Jose.Abreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Marek
 =?ISO-8859-1?Q?Beh=FAn?= <kabel@kernel.org>, Jean Delvare
 <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Wong
 Vee Khee <veekhee@apple.com>, Jon Hunter <jonathanh@nvidia.com>, Jesse
 Brandeburg <jesse.brandeburg@intel.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, Andrey Konovalov <andrey.konovalov@linaro.org>,
 Jochen Henneberg <jh@henneberg-systemdesign.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  platform-driver-x86@vger.kernel.org,
 linux-hwmon@vger.kernel.org,  bpf@vger.kernel.org, Voon Wei Feng
 <weifeng.voon@intel.com>, Tan Tee Min <tee.min.tan@linux.intel.com>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>, Lai Peter Jun Ann
 <jun.ann.lai@intel.com>
Date: Thu, 10 Aug 2023 09:36:15 -0700
In-Reply-To: <145d7375-0e58-b7cf-6240-5d8bc16b0344@redhat.com>
References: <20230804084527.2082302-1-yong.liang.choong@linux.intel.com>
	 <20230804084527.2082302-2-yong.liang.choong@linux.intel.com>
	 <145d7375-0e58-b7cf-6240-5d8bc16b0344@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Hans,

On Mon, 2023-08-07 at 13:02 +0200, Hans de Goede wrote:
> > Hi David,
> >=20
> > On 8/4/23 10:45, Choong Yong Liang wrote:
> > > > From: "David E. Box" <david.e.box@linux.intel.com>
> > > >=20
> > > > - Exports intel_pmc_core_ipc() for host access to the PMC IPC mailb=
ox
> > > > - Add support to use IPC command allows host to access SoC register=
s
> > > > through PMC firmware that are otherwise inaccessible to the host du=
e to
> > > > security policies.
> > > >=20
> > > > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > > > Signed-off-by: Chao Qin <chao.qin@intel.com>
> > > > Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com=
>
> >=20
> > The new exported intel_pmc_core_ipc() function does not seem to
> > depend on any existing PMC code.
> >=20
> > IMHO it would be better to put this in a new .c file under
> > arch/x86/platform/intel/ this is where similar helpers like
> > the iosf_mbi functions also live.
> >=20
> > This also avoids Kconfig complications. Currently the
> > drivers/platform/x86/intel/pmc/core.c code is only
> > build if CONFIG_X86_PLATFORM_DEVICES and
> > CONFIG_INTEL_PMC_CORE are both set. So if a driver
> > wants to make sure this is enabled by selecting them
> > then it needs to select both.

Yeah, makes sense. This is an old patch. Once upon a time the PMC driver wa=
s
going to use the IPC to access some registers but we were able to get them =
from
elsewhere. The patch was brought back for the TSN use case. But you're corr=
ect
that arch/x86/platform/intel makes more sense if the function is to be expo=
rted
now and doesn't require to PMC driver to discover the interface. We'll do t=
hat.

> >=20
> > Talking about Kconfig:
> >=20
> > #if IS_ENABLED(CONFIG_INTEL_PMC_CORE)
> > int intel_pmc_core_ipc(struct pmc_ipc_cmd *ipc_cmd, u32 *rbuf);
> > #else
> > static inline int intel_pmc_core_ipc(struct pmc_ipc_cmd *ipc_cmd, u32 *=
rbuf)
> > {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> > }
> > #endif /* CONFIG_INTEL_PMC_CORE */
> >=20
> > Notice that CONFIG_INTEL_PMC_CORE is a tristate, so pmc might be build =
as a
> > > module where as a consumer of intel_pmc_core_ipc() might end up built=
in in
> > > which case this will not work without extra Kconfig protection. And i=
f you
> > are > going to add extra Kconfig you might just as well select or depen=
d on
> > > INTEL_PMC_CORE and drop the #if .

Sure. Thanks.

David

> >=20
> > Regards,
> >=20
> > Hans
> >=20
> >=20
> >=20
> >=20
> >=20
> >=20
> > > > ---
> > > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/platform/x86/intel/pmc/core.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 60 +++++++++++++++++++
> > > > =C2=A0.../linux/platform_data/x86/intel_pmc_core.h=C2=A0 | 41 +++++=
++++++++
> > > > =C2=A03 files changed, 102 insertions(+)
> > > > =C2=A0create mode 100644 include/linux/platform_data/x86/intel_pmc_=
core.h
> > > >=20
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 069e176d607a..8a034dee9da9 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -10648,6 +10648,7 @@ L:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0platf=
orm-driver-x86@vger.kernel.org
> > > > =C2=A0S:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Maintained
> > > > =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Documentation/ABI/testing/sys=
fs-platform-intel-pmc
> > > > =C2=A0F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0drivers/platform/x86/intel/pm=
c/
> > > > +F:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0linux/platform_data/x86/intel_pmc_=
core.h
> > > > =C2=A0
> > > > =C2=A0INTEL PMIC GPIO DRIVERS
> > > > =C2=A0M:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Andy Shevchenko <andy@kernel.=
org>
> > > > diff --git a/drivers/platform/x86/intel/pmc/core.c > >
> > > > b/drivers/platform/x86/intel/pmc/core.c
> > > > index 5a36b3f77bc5..6fb1b0f453d8 100644
> > > > --- a/drivers/platform/x86/intel/pmc/core.c
> > > > +++ b/drivers/platform/x86/intel/pmc/core.c
> > > > @@ -20,6 +20,7 @@
> > > > =C2=A0#include <linux/pci.h>
> > > > =C2=A0#include <linux/slab.h>
> > > > =C2=A0#include <linux/suspend.h>
> > > > +#include <linux/platform_data/x86/intel_pmc_core.h>
> > > > =C2=A0
> > > > =C2=A0#include <asm/cpu_device_id.h>
> > > > =C2=A0#include <asm/intel-family.h>
> > > > @@ -28,6 +29,8 @@
> > > > =C2=A0
> > > > =C2=A0#include "core.h"
> > > > =C2=A0
> > > > +#define PMC_IPCS_PARAM_COUNT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 7
> > > > +
> > > > =C2=A0/* Maximum number of modes supported by platfoms that has low=
 power
> > > > mode > > capability */
> > > > =C2=A0const char *pmc_lpm_modes[] =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"S0i2.0",
> > > > @@ -53,6 +56,63 @@ const struct pmc_bit_map msr_map[] =3D {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0{}
> > > > =C2=A0};
> > > > =C2=A0
> > > > +int intel_pmc_core_ipc(struct pmc_ipc_cmd *ipc_cmd, u32 *rbuf)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_buffer buffe=
r =3D { ACPI_ALLOCATE_BUFFER, NULL };
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0union acpi_object params=
[PMC_IPCS_PARAM_COUNT] =3D {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0{.type =3D ACPI_TYPE_INTEGER,},
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0{.type =3D ACPI_TYPE_INTEGER,},
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0{.type =3D ACPI_TYPE_INTEGER,},
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0{.type =3D ACPI_TYPE_INTEGER,},
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0{.type =3D ACPI_TYPE_INTEGER,},
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0{.type =3D ACPI_TYPE_INTEGER,},
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0{.type =3D ACPI_TYPE_INTEGER,},
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_object_list =
arg_list =3D { PMC_IPCS_PARAM_COUNT,
> > > > params };
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0union acpi_object *obj;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int status;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ipc_cmd || !rbuf)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 0: IPC Command
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 1: IPC Sub Command
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 2: Size
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 3-6: Write Buffer for=
 offset
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0params[0].integer.value =
=3D ipc_cmd->cmd;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0params[1].integer.value =
=3D ipc_cmd->sub_cmd;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0params[2].integer.value =
=3D ipc_cmd->size;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0params[3].integer.value =
=3D ipc_cmd->wbuf[0];
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0params[4].integer.value =
=3D ipc_cmd->wbuf[1];
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0params[5].integer.value =
=3D ipc_cmd->wbuf[2];
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0params[6].integer.value =
=3D ipc_cmd->wbuf[3];
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0status =3D acpi_evaluate=
_object(NULL, "\\IPCS", &arg_list,
> > > > &buffer);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ACPI_FAILURE(status)=
)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0obj =3D buffer.pointer;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Check if the number o=
f elements in package is 5 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (obj && obj->type =3D=
=3D ACPI_TYPE_PACKAGE && obj->package.count
> > > > =3D=3D > > 5) {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0const union acpi_object *objs =3D obj->package.elem=
ents;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if ((u8)objs[0].integer.value !=3D 0)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
urn -EINVAL;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0rbuf[0] =3D objs[1].integer.value;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0rbuf[1] =3D objs[2].integer.value;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0rbuf[2] =3D objs[3].integer.value;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0rbuf[3] =3D objs[4].integer.value;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -EINVAL;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > +}
> > > > +EXPORT_SYMBOL(intel_pmc_core_ipc);
> > > > +
> > > > =C2=A0static inline u32 pmc_core_reg_read(struct pmc *pmc, int reg_=
offset)
> > > > =C2=A0{
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return readl(pmc->r=
egbase + reg_offset);
> > > > diff --git a/include/linux/platform_data/x86/intel_pmc_core.h > >
> > > > b/include/linux/platform_data/x86/intel_pmc_core.h
> > > > new file mode 100644
> > > > index 000000000000..9bb3394fedcf
> > > > --- /dev/null
> > > > +++ b/include/linux/platform_data/x86/intel_pmc_core.h
> > > > @@ -0,0 +1,41 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +/*
> > > > + * Intel Core SoC Power Management Controller Header File
> > > > + *
> > > > + * Copyright (c) 2023, Intel Corporation.
> > > > + * All Rights Reserved.
> > > > + *
> > > > + * Authors: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> > > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 David E. =
Box <david.e.box@linux.intel.com>
> > > > + */
> > > > +#ifndef INTEL_PMC_CORE_H
> > > > +#define INTEL_PMC_CORE_H
> > > > +
> > > > +#define IPC_SOC_REGISTER_ACCESS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00xAA
> > > > +#define IPC_SOC_SUB_CMD_READ=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A00x00
> > > > +#define IPC_SOC_SUB_CMD_WRITE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x0=
1
> > > > +
> > > > +struct pmc_ipc_cmd {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 cmd;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 sub_cmd;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 size;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 wbuf[4];
> > > > +};
> > > > +
> > > > +#if IS_ENABLED(CONFIG_INTEL_PMC_CORE)
> > > > +/**
> > > > + * intel_pmc_core_ipc() - PMC IPC Mailbox accessor
> > > > + * @ipc_cmd:=C2=A0 struct pmc_ipc_cmd prepared with input to send
> > > > + * @rbuf:=C2=A0=C2=A0=C2=A0=C2=A0 Allocated u32[4] array for retur=
ned IPC data
> > > > + *
> > > > + * Return: 0 on success. Non-zero on mailbox error
> > > > + */
> > > > +int intel_pmc_core_ipc(struct pmc_ipc_cmd *ipc_cmd, u32 *rbuf);
> > > > +#else
> > > > +static inline int intel_pmc_core_ipc(struct pmc_ipc_cmd *ipc_cmd, =
u32 >
> > > > > *rbuf)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENODEV;
> > > > +}
> > > > +#endif /* CONFIG_INTEL_PMC_CORE */
> > > > +
> > > > +#endif /* INTEL_PMC_CORE_H */
> >=20


