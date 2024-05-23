Return-Path: <bpf+bounces-30348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 403E78CCA1D
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 02:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69EFF1C2184D
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 00:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CCC1370;
	Thu, 23 May 2024 00:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flBvD0+A"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52517196;
	Thu, 23 May 2024 00:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716424234; cv=fail; b=ov4vtLtydZA7aUqy3nIAcVYpXwBQsS1+ky1wWuOHKEJasM4y23+kwIIeuIivwWD33gQFYZX7w9MoXuTqBHjL6Vfl0Qar3I2cRuAdcGN0xaCYUCb/9Eq2ycUl3Bq+c234kUHrdrSxI84Rx0NG4hQzchozb6hLHsMGwyFeLdzi9Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716424234; c=relaxed/simple;
	bh=wUm/nhdpQAxB+dRLA4b3MD7tQ8rb76An7N33Vqesyyw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tq4IVjslwyKDHFjpEzO9CzFnFNhikvb3pTOZ7tzK6ve4d8UIZceCuf8Th8BplXxLVDuvmksSDnyrsDn/9vyCM+ks2xe0LnJB1a4L7hvCBibbTtPsLSiZX7AXp5qFbTdEMYhgxZKWqN3MfO9p6pJcv6HRpT53jAIxcjDzbAwUfZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flBvD0+A; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716424233; x=1747960233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wUm/nhdpQAxB+dRLA4b3MD7tQ8rb76An7N33Vqesyyw=;
  b=flBvD0+AwDC8cvwSwBnU7AS3e3KVMOUbwXDqYXVfAGkgJe+uiR+57kK6
   RGES8KRa2htPFdZwJEUDcMMH6oGcnvMmgQb53tK+YQZA37TnUImcYpQ1F
   ZVb2Rhxcq0n0H6t4H+CYURymQAWvoqnbsttynKNnQrRs0F2d5BYkwYWX4
   LRnRw5PXN2g3tPT7k+MVTStdcLu36Pp7ci/4Mp//CPzVlugx7CAtEKWgI
   udgs9XpvzDVkitBPzTmBYHaJp33pqB7GHQ23ANCQVBP7N8+wDBUrb34WV
   bD9PCFFV9FHzFpT7Io2vf+79G1cY2AICtWXPSLKifWE2DjyKST9yi1Hvz
   g==;
X-CSE-ConnectionGUID: q4H6Vs/zQJ+woEIUjC2aow==
X-CSE-MsgGUID: BQbV6uCGTcChjTt1xRe0dA==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="12492338"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="12492338"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 17:30:32 -0700
X-CSE-ConnectionGUID: eKsbGeR8R+WWtwAI02i3nA==
X-CSE-MsgGUID: 8VsvJoqHQaWsrt1Wda2z1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33930843"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 17:30:32 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 17:30:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 17:30:31 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 17:30:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 17:30:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Th4wtI478IyWa+vd3pmg5FlFAIzjAKoa9b0saggP/6sQRi7T/N5o+cLHfrYSm8CdqOuqNVThmaEdSqyXzgLUBDvT439ZRmysdzYMziv96UJw5daqBRvjagTaDm68t+Z8XGt11TV61TYy4H5OB232wD+ULuN9abWY56RMBAV3htwzYDKhh7YZsqogyVTZQesflyd/BOSr/LBc74bdzlPXw0mbYROrPg48S9ne7a8pWx3HZ4/gY4GPYi9GS3RamIITBavbAO34de7GNXXRC+nr72agSSNNu5VMOvyRJWWpoCgjEHKbgWnBpXOv2sZPKyHC05Fkpedqb+AS+RBMArxOQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUm/nhdpQAxB+dRLA4b3MD7tQ8rb76An7N33Vqesyyw=;
 b=HywIBMwiUITcfbTaUhBR2ggjgbCXV9JYltixCA0ZzkOP7L1G5qKWcse18rl+FWSe7FL/76JWf5jPQFCOAUsNuXaT8rVFxrlSb9V4or9QCmaCyFpOBSnf2fTvWGxWRr7rV+WWopLoIqzlBsk1a/L9VS0DH6eJlmWBBYCEW+0ZD8HDyNPjlHDAW97rd4wrOpW/zWxtJfTL2loU9wais8cGuFc7c7xkg8YPlKPmzH6vUl4IRu/SCg3CPxXyshKIbcwBj06BQyrU5ldXoTDnZvBuo/IzvOMwHdGLXFoeWg7C3++9ft+c53VJ86nwOYTdv4+nqrC7NGlnPTWtTckPi2TOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4993.namprd11.prod.outlook.com (2603:10b6:303:6c::23)
 by LV8PR11MB8722.namprd11.prod.outlook.com (2603:10b6:408:207::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 23 May
 2024 00:30:23 +0000
Received: from CO1PR11MB4993.namprd11.prod.outlook.com
 ([fe80::92:1a96:2225:77be]) by CO1PR11MB4993.namprd11.prod.outlook.com
 ([fe80::92:1a96:2225:77be%6]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 00:30:23 +0000
From: "Singhai, Anjali" <anjali.singhai@intel.com>
To: "Hadi Salim, Jamal" <jhs@mojatatu.com>, Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Network Development <netdev@vger.kernel.org>,
	"Chatterjee, Deb" <deb.chatterjee@intel.com>, "Limaye, Namrata"
	<namrata.limaye@intel.com>, tom Herbert <tom@sipanda.io>, "Marcelo Ricardo
 Leitner" <mleitner@redhat.com>, "Shirshyad, Mahesh"
	<Mahesh.Shirshyad@amd.com>, "Osinski, Tomasz" <tomasz.osinski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Cong Wang <xiyou.wangcong@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Vlad
 Buslov" <vladbu@nvidia.com>, Simon Horman <horms@kernel.org>, Khalid Manaa
	<khalidm@nvidia.com>, =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?=
	<toke@redhat.com>, Victor Nogueira <victor@mojatatu.com>, "Tammela, Pedro"
	<pctammela@mojatatu.com>, "Jain, Vipin" <Vipin.Jain@amd.com>, "Daly, Dan"
	<dan.daly@intel.com>, Andy Fingerhut <andy.fingerhut@gmail.com>, "Sommers,
 Chris" <chris.sommers@keysight.com>, Matty Kadosh <mattyk@nvidia.com>, bpf
	<bpf@vger.kernel.org>, "lwn@lwn.net" <lwn@lwn.net>
Subject: RE: On the NACKs on P4TC patches
Thread-Topic: On the NACKs on P4TC patches
Thread-Index: AQHaq3tgsz8M4mwK5kOt/duOpn0mGLGj1UeAgAAMQQCAABa4EA==
Date: Thu, 23 May 2024 00:30:22 +0000
Message-ID: <CO1PR11MB499350FC06A5B87E4C770CCE93F42@CO1PR11MB4993.namprd11.prod.outlook.com>
References: <20240410140141.495384-1-jhs@mojatatu.com>
 <41736ea4e81666e911fee5b880d9430ffffa9a58.camel@redhat.com>
 <CAM0EoM=982OctjvSQpx0kR7e+JnQLhvZ=sM-tNB4xNiu7nhH5Q@mail.gmail.com>
 <CAM0EoM=VhVn2sGV40SYttQyaiCn8gKaKHTUqFxB_WzKrayJJfQ@mail.gmail.com>
 <87cf4830e2e46c1882998162526e108fb424a0f7.camel@redhat.com>
 <CAM0EoMkJwR0K-fF7qo0PfRw4Sf+=2L0L=rOcH5A2ELwagLrZMw@mail.gmail.com>
 <CAM0EoMmfDoZ9_ZdK-ZjHjFAjuNN8fVK+R57_UaFqAm=wA0AWVA@mail.gmail.com>
 <82ee1013ca0164053e9fb1259eaf676343c430e8.camel@redhat.com>
 <CAADnVQLugkg+ahAapskRaE86=RnwpY8v=Nre8pn=sa4fTEoTyA@mail.gmail.com>
 <CAM0EoM=2wHem54vTeVq4H1W5pawYuHNt-aS9JyG8iQORbaw5pA@mail.gmail.com>
 <CAM0EoMmCz5usVSLq_wzR3s7UcaKifa-X58zr6hkPXuSBnwFX3w@mail.gmail.com>
 <CAM0EoMmsB5jHZ=4oJc_Yzm=RFDUHWh9yexdG6_bPFS4_CFuiog@mail.gmail.com>
 <20240522151933.6f422e63@kernel.org>
 <CAM0EoMmFrp5X5OzMbum5i_Bjng7Bhtk1YvWpacW6FV6Oy-3avg@mail.gmail.com>
In-Reply-To: <CAM0EoMmFrp5X5OzMbum5i_Bjng7Bhtk1YvWpacW6FV6Oy-3avg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4993:EE_|LV8PR11MB8722:EE_
x-ms-office365-filtering-correlation-id: cec6f3b0-cfb7-4091-d180-08dc7abf88ab
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?MFZDOEkxVWdqMUF5cGJFNDN1NnU3dmxQMG9UMWxLV0dGSk54ZEV6MGNyRzhi?=
 =?utf-8?B?alZMTjJIQXFYenp6S0d1YkI2RWxNRS9NZ0FkRjlCZ0MxNU5IMkRLMGxIZEZM?=
 =?utf-8?B?dnVJeE4xWm43TndqQ0FmSUFiTUtBUllNd2dyVHFTN0ttbEdXaE1aMFE1K2lt?=
 =?utf-8?B?cmJ5WlJ2aStnWEFucllXZG9wMXRtRkJheEtjTGk3WGFpbUVzMXJWUnhJZjhq?=
 =?utf-8?B?QVBJVlEwRkJrUHV0dkJMNk1MQmhQcDBRV2NocEhJWVJiZStTQUZKc2FXUGRs?=
 =?utf-8?B?N0ZxNjkxdlBnQkVzYlBzcnBvb09VcEI4SEw5U0tyRGJXQkxwcXUxY3ZaMExJ?=
 =?utf-8?B?OTBGekVCbkNNenV0T0ZMdUl5SkVqeFN2VS80NGpNakd5eElnTFpxUU9OTDFv?=
 =?utf-8?B?Wk9kd05oUFp0YlRGN2ovU1VBY1VicXhmanFTYVByOWxoY29TZzAweUhsZHY5?=
 =?utf-8?B?bTNaYmhBaFFvaWlJMXdUSHdrMUxWeG1LQWZsUDN6ZGdTSU9ZREtEdndxMXVq?=
 =?utf-8?B?MWNmWkJEblpxM0h3Mzl1V05POXVjdzF5UFEyNDZJNGRnRVlrdlExTkYxMmE5?=
 =?utf-8?B?SUdWNzU1bkdDc2hmaklGRTFqUlZvSGEwSnF5aDZCREFoSStuRnFqK2N2cTJr?=
 =?utf-8?B?b3RNa0xGdnFEblNvMnlCMWpYQkJPRGhKVVliS3lJN0VaQmZWVzk0YzJJVFUz?=
 =?utf-8?B?S05JbHc4UDlqcldSYVdXUnFtWHVZL2YxQzRkeEZBU1VHczkxZU1wd2VTMDBY?=
 =?utf-8?B?ZDdqMGdud21GWXZuVjY2OVp3VDJMVUdjTjUyZG8vclhpZ1g4SVNSbVFzM3hM?=
 =?utf-8?B?ODh1RWxhaFg2MHFHaXBGQVMxZVhVR3QrUEpBdnQ4L1Q4OE1XYkFPYlNKN2tV?=
 =?utf-8?B?NkZ6VzZXSWVuNFNkTW1RbElkUzJNS1pGb3l0dHl4Q1B2NklkMDhFTFE2K0ln?=
 =?utf-8?B?UXc1Q0cvYWQ4YmdBVTdBVmhJdmJCTkZsd3hlellxbjNwMi9oRG1UbWlKQ21k?=
 =?utf-8?B?RE9VL3YyVU9xdnpKb3VhRmtTOVRVRjBnWVNla2Vwdm5nWURiN3VKRkxjK1lH?=
 =?utf-8?B?RGhuM2lhcytRNkVXb2tocE5Mc25OdXd3RHZLZnpBR29Lalpidml2ZlJnK2or?=
 =?utf-8?B?N0s3dHBkRnNuZndobXlNeE1hUnZMM1NLYXkrcmxMdGVDUHR0aVhWS01SU1Yx?=
 =?utf-8?B?ZWRJQWFMZThOZmQ0ei9sc0hCSiszakZOL0xnWlhJVXk3YUI4bStwZUgzV1R0?=
 =?utf-8?B?am56d0drd0JnQkdoQU5LNU9xQ21XMzBwVXEzSmx5Ylc2Y1c0TU4xM3dRc05Y?=
 =?utf-8?B?ajRwT3hCZlg3Z0J6MStyK3JEdCtUNW0vem5STTQvUzNkY25Gek1MQWlCNXBB?=
 =?utf-8?B?dVExQkNiWnRNWXR5VXRob2FVU29oU3J4eDFkNUtZclY1am81RWQ1d0NGZmlF?=
 =?utf-8?B?cjNMLzRJUGNqWnRoU0hDajErTXYyZFg4SmpDNUhUbUJmbDllQXhiMWFWMy9n?=
 =?utf-8?B?Y0RPZldWWDRZbFo4aDZLKzFQR0xPanpqVXpVaVg4TnJUbkZxT3RFeVV4T08v?=
 =?utf-8?B?NHB2NC9IU0JYYXlwSlY3QzI5UWVtSlJmZHBZSVlMK2k1QVVDZS9SRkFXdDJp?=
 =?utf-8?B?TFZBK2QrS3lDVGU1eS9XcWpYMFQzcVB5dTh4c0tLd1ExK2JraVJWMVhuSEQx?=
 =?utf-8?B?TmhyVCtYVERzejJJNU80cUhJSTRkQ2JMWVIzblJMQUJrcWNBZE1iSXh3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4993.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTFHb3ZuR1pQWTBxcWNHZkRpaVpTdUl5T1lMWXZyZkxCRXlKN1VqQ3V5cEhE?=
 =?utf-8?B?dEdYcjdDTGcrWjJMS3lPQkhBQ2loenJhb090QkJXdW5RU3crQ1hia0RJdmxn?=
 =?utf-8?B?ei9ZV1Z3Q1JTNk12L2RqK0M5QUVmcitZa3ZIWURudGV5TDJ6cThkZnMzaFFW?=
 =?utf-8?B?aEpqZml3c3pjem8zLzVmRmcvVHpQRVJ0NG9GaFA3WE9BNmYwT2dGVTN4eVZr?=
 =?utf-8?B?UFVOYW1tQjRYaklaUGJjdG5MaWttc1l6cC82V2xVVWJsSTFqSFhERjJvMEJW?=
 =?utf-8?B?SU90MzJSTzNxMExRM0FzR3VWTkFUTkVua2F5anpxVTg2MytJSHFSZEpzRkd1?=
 =?utf-8?B?OHMrOFV0S2hWTzVkNWo4TEhIWmZEV2NQUXhLcEc5N0pDNlRuVmIxVXdmMkpl?=
 =?utf-8?B?VHR2bDk3SFlMUFlJdUxiR0N3MGx3d3lhengvOUFIcXR4ZzAvNGtGMjlYcWVN?=
 =?utf-8?B?MW5UNS9kNElnWjdkMCtTZmI0NjV4TjJrZWhGWlp4Y1NJTGMvSXE1dTZvb2dV?=
 =?utf-8?B?c3VDRDRKUVNWSDVKQ1hGeXFzTDQ5bmFkNGE2cVV4ZlRTVExYcFJPdUV4bmYr?=
 =?utf-8?B?YVAwcjJNUExxandlQ2VscDBobCs1bFh6bjBzbkw5aHdxejdYWUsvQ3Y0a2tP?=
 =?utf-8?B?SDZBNW1jaWhvYmY2ZUhCK0tjQ0tkN284bElWTCtwREtPWWFnb0ppNVVTQnla?=
 =?utf-8?B?VTgwcWdrRXR6a0U3RENHRnBoUHlZTzYwdlJxS0dTYU5TZWd6M2xTRmltRW1M?=
 =?utf-8?B?WUM2RmU0d1FDTkJJT1VxRVBsUkUwTFVTa0lwWS9CWllBM3ZxZ3ljRHlRdDMv?=
 =?utf-8?B?VEhSQkYzSTBZcU91TjMyWjhES2Q0TmY4TGRRdlpjZXlQaFJKMEYrVVREaGg2?=
 =?utf-8?B?ZGdyN2RhdWMrbFNzQ3Vzend3emZPczI3WVJFL0tLT0dIRk9NdXNEQTlpOGJw?=
 =?utf-8?B?anNLRkQ0MUdDR2NtYkkya1Bwd3NBSVQxYU1aSjBVK0haM2RTdTJOWWViY1lt?=
 =?utf-8?B?S0ptN3NsZ2FPZDFpRmVscFI5K1M4akZTMUU0RXFNY3hQQjdhRnFoM2pVRUFm?=
 =?utf-8?B?M25mMndFTkZoUHNwWUs2ZUNubkx6ZndJamUrcnVQZm9Qa3lINE5kUnNySEph?=
 =?utf-8?B?aElkay9sSXNqT21seUpzWCtRMmMwbUNaRlFMRXFNankyOGk3MjRrdCtTay9R?=
 =?utf-8?B?THNqZnZYTk9GSG5WRmV2Z281a0xhemlSNVhRbmpHNFNLT3pFMmtMV0lOVi90?=
 =?utf-8?B?NzF6dE93NFRqVkRTUHBYZzczV0JTQXZWMllaT2g0eTlWck5IUmQxbENjaHVa?=
 =?utf-8?B?d0ZnanFNZ1NPSUROaFNpZU81ZnplcklnNzdoNVBnTUNJNkVrQmxXaGo2UExO?=
 =?utf-8?B?RnVJcmZ5SHRrN3cyYzkwdmxYQ09JN1NiaUYzcEJhQzhKUm9NbzNUWUcvYTBW?=
 =?utf-8?B?cmJ2NUxaOHlmcHhTSGxHblFMNEN0ZHFYcVJpSzAyVkZSL2NQYUZXY2dST016?=
 =?utf-8?B?ZUdRMUpQOWJmWkVJV1NjU3VCbGdISkhMZFZpdVd6SHFYbVZGWG5pRGt1OExB?=
 =?utf-8?B?UkREMVVyTGRRU1grc05Tc2kxZUIzMzdMalhTSUdrNVRIemZ1VThJaFdJVkpB?=
 =?utf-8?B?R2daTkUxK3I1SXNtRVBId3RUQlNXaGJmNlNZZzJPYzFJZEhEVGpKYy9oczFJ?=
 =?utf-8?B?Ym4vdkVWbVhRTm9WaktIUlFYcDcxVW9CZ3ZMWmQyaUxqcC81cjdSMFRYNWho?=
 =?utf-8?B?L3pyck1uZE5jcjJPVnRvd1ljRkp5a1NFRDBnek8wSVBKV1dFd3ViQnVuTDha?=
 =?utf-8?B?TmdJZWl1YXNkdmRIL2Z0STE5OFJNenlvRTFzeCtaMzl3Q3p0MkFJcGxFVG9S?=
 =?utf-8?B?VFdKMzFnMUFVWmpNTDJJTFByMzhKbXI1NlZXV1BNWjZRdjFvblNOK0lQS2NS?=
 =?utf-8?B?aXFKRlJmUEV2a1IzckpiZGxlblNYNUROUWxRMkRNQVNvdVBJbTVhcmgwS0py?=
 =?utf-8?B?cFhtaFVFYlB6aGhZTUFZNU8xcUZoK2czUytnejdOQ3YzMXdCTzM5bGhKMGt4?=
 =?utf-8?B?VlBhY2UwUmFhMzFSY2M5SndZZEtFU2pxNDh2Szhyc3RmYmNPM1hWOENoVVZo?=
 =?utf-8?Q?gqdOiLip9RULx8Zf7OZgpLpl8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4993.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cec6f3b0-cfb7-4091-d180-08dc7abf88ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 00:30:22.9556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x0wMNBAf1IhbjvITjfifA6ZW4JBsSjUWaohQJd5zHnxUWAHcaIzbLXxnAmoumRlKsof1t4DEtvBSVWuIBwLr7MX9WpQtbhZsSTxAEVdtAuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8722
X-OriginatorOrg: intel.com

T24gV2VkLCBNYXkgMjIsIDIwMjQgYXQgNjoxOeKAr1BNIEpha3ViIEtpY2luc2tpIDxrdWJhQGtl
cm5lbC5vcmc+IHdyb3RlOg0KDQo+PiBBRkFJQ1QgdGhlcmUncyBzb21lIGJ1dCBub3QgdmVyeSBz
dHJvbmcgc3VwcG9ydCBmb3IgUDRUQywNCg0KT24gV2VkLCBNYXkgMjIsIDIwMjQgYXQgNDowNOKA
r1BNIEphbWFsIEhhZGkgU2FsaW0gPGpoc0Btb2phdGF0dS5jb20gPiB3cm90ZToNCj5JIGRvbnQg
YWdyZWUuIFBhb2xvIGFza2VkIHRoaXMgcXVlc3Rpb24gYW5kIGFmYWlrIEludGVsLCBBTUQgKGJv
dGggYnVpbGQgUDQtbmF0aXZlIE5JQ3MpIGFuZCB0aGUgZm9sa3MgaW50ZXJlc3RlZCBpbiB0aGUg
TVMgREFTSCBwcm9qZWN0ID5yZXNwb25kZWQgc2F5aW5nIHRoZXkgYXJlIGluIHN1cHBvcnQuIExv
b2sgYXQgd2hvIGlzIGJlaW5nIENjZWQuIEEgbG90IG9mIHRoZXNlIGZvbGtzIHdobyBhdHRlbmQg
Yml3ZWVrbHkgZGlzY3Vzc2lvbiBjYWxscyBvbiBQNFRDLiA+U2FtcGxlOg0KPmh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL25ldGRldi9JQTBQUjE3TUI3MDcwQjUxQTk1NUZCODU5NUZGQkE1RkI5NjVF
MkBJQTBQUjE3TUI3MDcwLm5hbXByZDE3LnByb2Qub3V0bG9vay5jb20vDQoNCkZXSVcsIEludGVs
IGlzIGluIGZ1bGwgc3VwcG9ydCBvZiBQNFRDIGFzIHdlIGhhdmUgc3RhdGVkIHNldmVyYWwgdGlt
ZXMgaW4gdGhlIHBhc3QuDQoNCg==

