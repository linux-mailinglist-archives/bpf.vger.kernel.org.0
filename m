Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30166D944B
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 12:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbjDFKlo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 6 Apr 2023 06:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjDFKlm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 06:41:42 -0400
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (mail-cwlgbr01on2066.outbound.protection.outlook.com [40.107.11.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7CF55A6
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 03:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnGkb14v5s1+uyDR5bA4TvpXVD7GevQGUA7oQEp0ttK5v40jEYRBCkrOVBZvkt5PXUUgJYKo0lqRyJoBB1W97gandwEMOctr4MFVhvNWQF8YHXWBqqeROKsQGSnt3PwznaUL5LjA/fxXdYEsp89J/9qR6Okl2+XP0Zet1JaGLOFU82hMXqyMeCCBG1cpJwdU3Uz5pf/NHlUGlCY/3098x4c+jYFk9TNfbu+QhyfzWoH6pV7tBk3eUejlkm9OsU8xdn5kzYrEeRrs/kdWykYsRyLq2KNtK5hZooDFTWVlrx6kvd1KwYLUhvUllRoMHf3wj406YK7u5sDItPNBSsNDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLuXCb/fcJIAkMSJLKZXdOgJY2aPuuAZFjIqvreKccI=;
 b=YFwBRYrXAkhgrQBdUUMM3OU1EhQ8liuLQhH5ciXZ87zqskk5Wjt62Tkkb7ka1GN4FTHPpdAx+IFEe9yu7MgxMfctmImcDikOeXbCHCKT3xwOOSBhCnX3THoR/VuEd4DkJVUTsh1xgK+TkVd8JFiRhmB+AgmGVeGXtbDA5RzSzYqXS1wc30qEZcGOwYsI4wloG5wLCLbTDud+XZg/fwN/N/K3dBu8Js0kDn73nVBgl17rx9SCdbY6a7ed/9LKEaDpmlnLPYPvq/7tJ3lKBDJ4HqD1L1WAxc1S71U1L174i70aEam7ZA/78gzigZeZEbnGhMwXtNxWAvuHCGv0mOKXhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=manchester.ac.uk; dmarc=pass action=none
 header.from=manchester.ac.uk; dkim=pass header.d=manchester.ac.uk; arc=none
Received: from CWLP265MB3267.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:e2::8) by
 LO2P265MB2589.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:13c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.35; Thu, 6 Apr 2023 10:41:37 +0000
Received: from CWLP265MB3267.GBRP265.PROD.OUTLOOK.COM
 ([fe80::5e49:c5b1:effe:9af8]) by CWLP265MB3267.GBRP265.PROD.OUTLOOK.COM
 ([fe80::5e49:c5b1:effe:9af8%2]) with mapi id 15.20.6277.030; Thu, 6 Apr 2023
 10:41:35 +0000
From:   Andrew Nisbet <Andy.Nisbet@manchester.ac.uk>
To:     "bpf@vger.kernel.org " <bpf@vger.kernel.org>
Subject: EBPF/libpbf initialising/reading raw (hardware) performance counters
 BPF_PERF_ARRAY
Thread-Topic: EBPF/libpbf initialising/reading raw (hardware) performance
 counters BPF_PERF_ARRAY
Thread-Index: AQHZaG7ZKpetQMWGrkOs0/GK1n44JQ==
Date:   Thu, 6 Apr 2023 10:41:35 +0000
Message-ID: <CWLP265MB326715B58C33134FB24B913FC1919@CWLP265MB3267.GBRP265.PROD.OUTLOOK.COM>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=manchester.ac.uk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWLP265MB3267:EE_|LO2P265MB2589:EE_
x-ms-office365-filtering-correlation-id: c01b6452-e40e-4b4d-9f37-08db368b7e70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DttlD4nxqEkfq2PFK4MZRpr1a+/Sq5gbJhPEF3mIAwW0kTBxBf8SETKuYS4fm1ETrE3gbLwX1zNMFLWTQ3EiPEF0J2RJ6kvPXDe5PH1Eo2u6iU3mJiqF/WgnC+xRGmXdD8XZLcasipoUmbhcxkduRmFdTmXdGD5Uw5cClL2DQZ0B9uuBet8QdpnWZXS3ZIvRx0a+4ClMhQLr1uMJ+dNRmaiJLQRSLVfmVr3/meAOEPIRUqGy7ZtyTrA7kSNCGSXipbylYQjfvJ6cE9/C3kREs8gFZWOjYMLvU1S54z6XkaoFIa8uhDOKo1ewNkZdvMO6WJdGsxn03NNAkQ+1GAMjNKnrNHoTwethpbqgVIY3OSRpUVzsFEFr0U3qPqawpyZwM/sGWdcZsr24CaiwS0j71YyhIyqSZVDKCV1Tr7q0voaSy8Th7KFm3F8qVLB5Zl4MSGilHmkESLv3wmq/bELmzDrlERUkEYincMtr/S1Qv4cDc2yYWJ9SuAkJiCN1DFXMNfv/jEm6Nmy+7lRA7LhqrUFIZRO5LIUdB2BASzomfWwmXixVaL1X4sw6/btuYhCjYS4W1eN02j8bS2SjIxEVkG3gzg/Vx+zcrrW0K68wCCpypjoD3PkaaGjEu6piq6od
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP265MB3267.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(451199021)(5660300002)(8936002)(91956017)(786003)(316002)(66946007)(2906002)(52536014)(41300700001)(186003)(478600001)(64756008)(6916009)(66556008)(8676002)(66476007)(66446008)(76116006)(7696005)(71200400001)(9686003)(6506007)(26005)(122000001)(55016003)(33656002)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/QTiznfCtYwqA4Gz0St78n8Xy1oEjS+IGTflsSqFipezX9bOC/mLKnjVVb?=
 =?iso-8859-1?Q?JVoqEYzpY5Q0jUqhIdwebMAp6nO3Y+BcalgTsB0hDkH8+rEEF7Y7abSgx/?=
 =?iso-8859-1?Q?y+en9U8sCNL7vlP8krfF0lllcoYPVHhKFEuhiJ46IWCfs9yu9ZlPgcHUxR?=
 =?iso-8859-1?Q?A21y+sUqvHmy2i1ame1KcoblSUAIF9Ym60gkFSFWtA3k1stH6TDXoY+b2o?=
 =?iso-8859-1?Q?ZmiltKiZ9r1yaTQBXHv18HVgkLP1JEOG0Ix1nw/hJrFTKuxHG9D0VKSXtt?=
 =?iso-8859-1?Q?HV/GBI2obI2mYBGL+q0nuwKpOX0hgFZ09Qt2hQpw2IP6gPd2xSnQXl+msp?=
 =?iso-8859-1?Q?LQgcIIveMTieyI8g4gXpeLELACk+Qz5VgoxLYcG+8ajNbt0uiKysdvmrBT?=
 =?iso-8859-1?Q?99oBzNx3rzmotRqYEFKv51WhBb3CAuNi067HK/hVpiWETq2Y0hPx/PxtIu?=
 =?iso-8859-1?Q?MMzKw+yBbKNlBgs7y5UWJOFzrpgNyb2rqn/MfocdJGcO+LSu4daianPV6l?=
 =?iso-8859-1?Q?io/EOa2/QDhubPCaBdMcEzFeWQ805DE0tBWBHwdBvoX48j3x44jGBPZjsI?=
 =?iso-8859-1?Q?3EY9AcUMAFM/c72TZtHqrLT+M9SqVYhTchew8B2d1sNgL0FcbbrJrbZa3V?=
 =?iso-8859-1?Q?s7CQSnBPetZvLcq0NnFCWDSy/ZMTc5J8xJj/e37TCOm86afWowqH14+etK?=
 =?iso-8859-1?Q?xb22w885uPxFT0gU9/t8Z9Fq9YwlY8dGKJOllnfNXXEgWvnPkf1JDC9wyx?=
 =?iso-8859-1?Q?JtZpcKjzDpFCIHYn1MYQ2Gr0y/q3Jg2ukeBSLNiLaKUNmQEQ4WmyXCkhxa?=
 =?iso-8859-1?Q?emzL417zgNw05qUmbpwgLW4BdLvsE/ftSgI27hW8wR9GdLt9fdTzBpwuLb?=
 =?iso-8859-1?Q?sbON8LDmFEKPBuAgKHsPZZ4C8ynmIc6b814h7TMytq0ROnioIJz4WsK0vD?=
 =?iso-8859-1?Q?uQ0OGsMW8F9lzlQDg61sBqOIpar5jmowT24Z5qbVXMjHWFp0FIhdgFHD3q?=
 =?iso-8859-1?Q?VJFOPsL58nmv4llSpJQvuWOy7nHgJ2RLZLyxhYLzLUqBGcUzVh5+3hgHVG?=
 =?iso-8859-1?Q?bFxOxIS8TN2b7XnmeA0U5c8xLMjFs/2mWdbeKWtPcz0EoqYko3iYEVxJOH?=
 =?iso-8859-1?Q?NcyltrlxaDYcd45SV1kvaxmzS1fXCY2QKEsNyI20MEiNEqjQROdH3oN4hm?=
 =?iso-8859-1?Q?U8YL0N0O8SVqCTGXBVr5a3v5ivf68qU18KMVjNZdUQpNr0pq4MipvprfKu?=
 =?iso-8859-1?Q?UEDKX2yJV53z5SsERtyH4lzPphmYQK+vrqPS1L7hREPxPnoV+D2HmiJoJN?=
 =?iso-8859-1?Q?HPP7P0J37QJzLvs24FbRdKJIxW80jBCa1h6cquh4uFpF4/BpTSYxitUyBm?=
 =?iso-8859-1?Q?RfCAtbi0rrchiUhmSazwEY0cy9v0LUyQb9tslxTq28BuY6XpVhTI0OKfxs?=
 =?iso-8859-1?Q?XbM0Db0c2F7qUv82rY+Kq79lWhSGPWsu4DUG9uMOnu0IEpgOrUNM0Wyx8q?=
 =?iso-8859-1?Q?LVd8DQdunK0Isq2y8Kq5PvzAEe71zphpLsysyQbjJjvK1QXC5qI7u0Kpo4?=
 =?iso-8859-1?Q?IqteSz9Q+wF9whlmBydAbGLTuatKzAINZv3sV4jJjrhvxmyTM8iTSW2l57?=
 =?iso-8859-1?Q?T9sg5oiIBk79d8/nq6vFzBbqaXopr1q4aH8JYg3sqvWykcQVVrquU+kg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: manchester.ac.uk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB3267.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c01b6452-e40e-4b4d-9f37-08db368b7e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 10:41:35.2506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c152cb07-614e-4abb-818a-f035cfa91a77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pOOaTieCm8Y0rI5qetOOUTZzPUMXVrUeDF15ohrU5AZrmTJWYyEUD7u2PzIZw7DKfhHY7+awB52nnsqQv1IF5AYMZKJ8EdpLx/Aw+KiQ3/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB2589
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,
apologies in advance if I have missed an obvious information resource.

I've used BCC/eBPF before to generate a tool that attached to sched_switch with performance counters and that traces the per-scheduling thread quanta changes in counters for threads of interest. 
I'd like to use libbbpf to create similar functionality to something like ...

perf stat -e LLC-loads,LLC-load-misses,LLC-stores,LLC-prefetches -p PID --per-thread
The actual counters are immaterial - except that I expect to be sometimes using RAW performance counters, and I typically extract the perf_event_attr information such as event/config etc using 
perf stat -vvv -e counter-name /bin/ls 

I can see from the libbpf examples how to catch the pid of the command as it enters the runqueue, but I dont see how to initialise the raw hardware performance counters to only count the pid and its threads (is this even possible or does one just accumulate counters for each relevant thread in sched_switch - this is what we do currently). I understand how to put these values into a map. 

I'm looking for (if possible) example code or information pointers on how to initialise and read the counters, not using sampling - presumably using a BPF_PERF_ARRAY map and a call to the  perf_counter_read or the older perf_read on the map. 

I'm only just getting up to speed with libbpf, so apologies if I've misunderstood and presented BCC ways that do not apply. 

Thanks,
Andy
