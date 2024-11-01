Return-Path: <bpf+bounces-43792-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C39C9B9A5A
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 22:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0DDB1F21435
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2024 21:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4481E32D9;
	Fri,  1 Nov 2024 21:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b="UKdwyV4s"
X-Original-To: bpf@vger.kernel.org
Received: from esa.hc503-62.ca.iphmx.com (esa.hc503-62.ca.iphmx.com [216.71.135.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8732725634;
	Fri,  1 Nov 2024 21:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.135.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730497641; cv=fail; b=nClHnWd97cPrD8w5S4AoNtZ0+3bBgI4KZtKInEOD2M8huo1nRrfQK4Lne6JSeXs8sdCBuaMH4m00TyvH77zB8iaN4aHvUWISAq20ojkuYNHZGwYSjQ6YV2OOSFRlWBrm3ovAFTKvsIaJS5xZ9HE4SSax2DdYQm5rgBAtc7n8vSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730497641; c=relaxed/simple;
	bh=Y9S3+R2z4dhafPCkH0OiA1IGEWJflVx1cKHNRQ9ZKKk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TBoDH99KmVxbgBjnE/OWt35NFwDBsp99W4ajnjPAejNVHsHqEikLUBPAFXpEhqyRVEnc2h28dULAUmaU1kGw3y7OXmY1+UlDHp+7wsMvh5lnniLpaHM3tkTq3aKK+FDqhnwqgfY0EpPhjQySchWa0vzuxQeVrX5e4NeWRTP860Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca; spf=pass smtp.mailfrom=uwaterloo.ca; dkim=pass (1024-bit key) header.d=uwaterloo.ca header.i=@uwaterloo.ca header.b=UKdwyV4s; arc=fail smtp.client-ip=216.71.135.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uwaterloo.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uwaterloo.ca
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=uwaterloo.ca; i=@uwaterloo.ca; q=dns/txt; s=default;
  t=1730497640; x=1762033640;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Y9S3+R2z4dhafPCkH0OiA1IGEWJflVx1cKHNRQ9ZKKk=;
  b=UKdwyV4se5DBslJWswXSmlOACwmvWnONo1Ck1ymH7PtULCK0Hb6bmIGk
   DCb4wsTQjKIq+QMTeag4j1+fUqgodHhxuHidGs3DuU5ZaP92N2nTkqHcP
   wCwDbjZ1UJKX7k96pDlI5LX8xLytzKEb64T2E2e+dqnYlckiF/0VgQ2i7
   c=;
X-CSE-ConnectionGUID: PVlqM8EqQJWrHeyZhGQSaQ==
X-CSE-MsgGUID: UQCH678cSmOddWt/vqa5+A==
X-Talos-CUID: 9a23:CXljNG5yZ8oIjRKseNsszHAQA+V1X2Tk7kjKA0KpO2ZGcYaccArF
X-Talos-MUID: =?us-ascii?q?9a23=3Av1a5TA5n3da9KfHjVMHNBS3xxoxV2o+OVh9dmq4?=
 =?us-ascii?q?DnMWICjA3JS6U0XeeF9o=3D?=
Received: from mail-canadaeastazlp17010005.outbound.protection.outlook.com (HELO YQZPR01CU011.outbound.protection.outlook.com) ([40.93.19.5])
  by ob1.hc503-62.ca.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 17:46:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LH9sQEIRBPWkMGpIm84MXfI2X2cgtti+lsATmt8HAvVM4xZjpWr0WxfoJQnk12j24JfMPsMo4wUUQHRnN7e3ldFGE3J+nQqIQrEO4KNONsRzWk5Shlii4mFzKTpBht3MsRNi8E5gDIYKsEmy6J0MHeivDiK0b4Y6fWMfTCi0TlRLECSpZz91UUno1vwT5ELINAGMkdyIlpotvqetK6GEg/nt5XrUtROQ6iJ4aKEgR/zSS3h9cXGJUJB4JMhTeW1W8n0jjtEsfObBWxQ6+Gi1MAe7pGgeEQt+affAj03qk16VDd2SArs3/ZDN10yfrESGsFjxgIeD/5kAm/8o05+oHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C81RSP48QV5NnpmxBdzYLnUpMzOePlFIhx8NtlwfVkM=;
 b=QkChXm7ZduqPjPXt+Sp1DTfivxCkWRuIeOsFTrbGrQBVpX/KpCWlWSluynBBeoD0ndvwf4fu79pNRWnX1raQXlWDy5LPcV/iMpCNmUogYX/r4PKLZ3eRXQNbiAfs1iAG03yvQdloRkZNvPoAP6XToelebxI//U1J4lKeRXSOlswhwa8W64F7Ie5X9+DmLk2qMi3RRLpXbpaykWOMLebV4lvpUHMU4t0iYvq0S0EbnSXZyLZBi97LQhn5Dukfc04GW/G5i0v39zA73CtW3O9ZuuiBQkOs+4PJncVqOVZqy+iAzBmYj/iB+x/pLuduXC/m1XhjC9ioYOH3cdBGYqJZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=uwaterloo.ca; dmarc=pass action=none header.from=uwaterloo.ca;
 dkim=pass header.d=uwaterloo.ca; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=uwaterloo.ca;
Received: from YQXPR01MB6575.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4c::22)
 by YQBPR0101MB5624.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:44::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 21:46:07 +0000
Received: from YQXPR01MB6575.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::43e4:35e9:8ee3:fd81]) by YQXPR01MB6575.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::43e4:35e9:8ee3:fd81%4]) with mapi id 15.20.8114.028; Fri, 1 Nov 2024
 21:46:07 +0000
Message-ID: <b75bec0d-e083-46e9-96fe-47abbf089cbd@uwaterloo.ca>
Date: Fri, 1 Nov 2024 17:46:03 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 7/7] docs: networking: Describe irq suspension
To: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
 Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org, pabeni@redhat.com,
 namangulati@google.com, edumazet@google.com, amritha.nambiar@intel.com,
 sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
 bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
 willemdebruijn.kernel@gmail.com, skhawaja@google.com, kuba@kernel.org,
 Bagas Sanjaya <bagasdotme@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:BPF [MISC] :Keyword:(?:b|_)bpf(?:b|_)" <bpf@vger.kernel.org>
References: <20241101004846.32532-1-jdamato@fastly.com>
 <20241101004846.32532-8-jdamato@fastly.com>
 <cd033a99-014c-4b41-bfca-7b893604fe5a@intel.com>
 <ZyRbZpCiANaxNNlv@LQ3V64L9R2>
 <f9cfcffb-203b-4ed1-82ba-14fed2252c7e@intel.com>
Content-Language: en-CA, de-DE
From: Martin Karsten <mkarsten@uwaterloo.ca>
In-Reply-To: <f9cfcffb-203b-4ed1-82ba-14fed2252c7e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::28) To YQXPR01MB6575.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4c::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQXPR01MB6575:EE_|YQBPR0101MB5624:EE_
X-MS-Office365-Filtering-Correlation-Id: 395a768c-01f0-40f6-cfe3-08dcfabe9782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0piYzFreWprYWpBSyswUXpIV1dBL3Zqam1RTlhGWUdJUStwMjUxQTlUZUda?=
 =?utf-8?B?UitDdlBxeC9BeElSUUJ0T0FJRi8ranpTa0JwZnRDUDV6bVd3cWoxSS9VSVpl?=
 =?utf-8?B?Z0dYaDNFUEZyTHF1VHVpTnA2azlCczBpTkJnNzM5L1dKTFZUeXJ5azdwM3dX?=
 =?utf-8?B?RVNLUTZqRUVLK1BJSURGcWVuc0FKOFYyYjE5OXZhZGlPdzlnUmdoWFZ3NFoz?=
 =?utf-8?B?Z1BMUjJkcmlRaWFtaEpnOC9nSlpnanpqdTVUWUFnQ3VsTldXYmUzWVRLcVN6?=
 =?utf-8?B?aElGWFRaa3NpU3laYm9zQlFmUTk1NVRCdWVLV2FEbW1iR0FhOG9IZGNlN3RS?=
 =?utf-8?B?NWYyQmM0TTVtcEV6Z1pQTlNlZ2k0cmlIM0hDY2lrc05lLzhnQWxQSXBDNXB0?=
 =?utf-8?B?bWhrN1Nmc24xbjgwTkk5MFBnVDhVOUdCZ3dyYk1aSXQzbDJsUlZieXFYQnor?=
 =?utf-8?B?WFJ1bDE4N0VFQkZ3bUxqVklsNnhPdGlqZXFHZHYvaE9hWE5sOGVHeFFUQUlU?=
 =?utf-8?B?aUY0akxzUmhPWlVFQjNNdVlsenQ2Skp1RVduWERndHk5RWkyc0s1MjRqUThs?=
 =?utf-8?B?TlNUUTJhbjRkRm1XOEtYa2oreVdaOEdUNGFMZ1J0cGtscU9OTkpCcEN3NjVW?=
 =?utf-8?B?N2Y0UFVTVFJJQWZ0TzhlVkZua2I0VW1Tc1YvTTJXUDFMZWNXSjcrT0xUb1dz?=
 =?utf-8?B?RmRPZGJPUDR2RDQ1TE5YcSt5T0lOazBIbllIalRrQkF5cXJGZDV5dHlYaXNs?=
 =?utf-8?B?YnRDckJ5ckxpWTNEbzZEckE4cDJYSityTU5tcUpwM01rRlRNcTBkZ2Y1TnZ3?=
 =?utf-8?B?dkNLRFFIMlJGeUFvOEdTalBjUGZSaGEweTdVVHNycnBmOHhZbUpGaHV0M3JV?=
 =?utf-8?B?UkRveWJuVHdIREN0THVjMTM5Q0sveFI2dGprOGdSWTJ0N2duY0tEaG1JWitO?=
 =?utf-8?B?dXVVdUZRU1hKaXlBRExXc3daUXdqeEQraXlkb29QcFJhM0pUN3JRdVFaWDZL?=
 =?utf-8?B?elJKaVF4MklhYjh0RHZDcUVPY0RMZ0pxSUJrdzhLd29xMTVZaE1rOXhzS21h?=
 =?utf-8?B?WDF4WnEzWlNHMmJ1aGJONENtNlQ2VWVGTFcvL3l3UXcwOGIwWExSYmhMV2lj?=
 =?utf-8?B?T3llTnF2ejAxSis5aWhSaENjYVErWXJSWFoxYlBacmNsTUZHUVhCNTRESEZ1?=
 =?utf-8?B?OHVzTEVrZCtKcCtrc2FIMHhMUzF3bVBMeTFqMkt1WHRnR01YdVNnRXdYUjA1?=
 =?utf-8?B?LzUzcy9uT1VubThFSC81REJjdHJhdVlHZktWMXI1R29XWjB4Z2RkNFFWbG1W?=
 =?utf-8?B?N1crM2lLMjl3R1B5TjJvTU9ESG5EZmtjSXVEZ0l5NXljb3Fnc1VDYnBJZERz?=
 =?utf-8?B?WVVUdm5nZlpBNVZnRlNHWEhyUURCWXdxOTFGRTFhb2twQ0x2Sm5GbEN5OE8x?=
 =?utf-8?B?S0Zad3JqZjMya1ZjRVFGL0o5TDQxSDV4K0M2YkpEblpLbUFOZUJ4UDh1eTNB?=
 =?utf-8?B?R3BTNzBtTUV5NGdtVkZ1NFZhdWExbU10TDBESHl2OVczeFNOdGdjMXdYUVl4?=
 =?utf-8?B?b2FRRnlNdWhsRUtHZStlci9ZMkhtOEVxeG4vaVdNNmhRckh6VTE2T2lFL0x2?=
 =?utf-8?B?cEdvdC9oc0JaNWxHVzhYdTRkN1hpTE4valF2YnRaa0JlYzdUTHpKbEtFcC9U?=
 =?utf-8?B?SHpSakRGUDRLTk91K1pWV2pDL1BMaFBrdFBKcGVTVERZZnNjcnRTeDVhNng4?=
 =?utf-8?B?dEl2MUxSVkR5ZjcrMUNpSkZwS3QxQlp5YWtCMmt5OUc5WHp3M0lNdzUvRzV5?=
 =?utf-8?Q?3/Gw59w15ZiWfvwUnf3vhd/iU6goOi4U2Prtg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQXPR01MB6575.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGdaNE4wajZ3cGdhOC9JL0JxUXozMkNETmdGajQvamVYSzZlSDRlN295MmF5?=
 =?utf-8?B?UDJ1bERScjgzc256T20xWG0rSFhXSzZFdFh4Q3BhcWJESEx2ZWhBVEkxQ1ZY?=
 =?utf-8?B?dDQwN01QM3plUk93bDJHTW9KZVhZOFBuYi9MenJwM3RhMFM4elNZQlBCa25l?=
 =?utf-8?B?UE9vOFVFeTlCa0pCOVB2WjNnZHVReUNjQVhXbzM3bytDM2xyczA1a3NxblFo?=
 =?utf-8?B?NnRheUZsMTVNUmhwMTRIK2ljNmNHbFdLS3JRWWEwU1phSDRvYWRrOURhNWFu?=
 =?utf-8?B?bVpzc2dOYnZCcHNZNUVxT25vVzZEU2Q4ZlE0MUVsL0ZYQzh0SXIvRWpwSzV2?=
 =?utf-8?B?bmQ3aVdvQzlTSzduNk0yUUNqaDg2OXB0YXY2RDhlR29wK04vOXhNeDF5VlJh?=
 =?utf-8?B?M0F4ck1KMjhjTlFVc0Q3SEVhd2hOMVp0eW1MVDR6eFIwMXkrelBLZlpIdTNq?=
 =?utf-8?B?MERvSWhwV0ZDNGxIMEVoUGQzRlVIRkdFdEE0VGoyNW9sdjFHbjBnc0gxUlBj?=
 =?utf-8?B?TEpLVTQ4QzRTcGhvRjVyUE4xTm44dzZYS29aMGVLa0JOS0kvSkJERldpeUtR?=
 =?utf-8?B?MU1wNkt3d21pZ2pLT3lVTjRYeU1GVllES3M4OFpsRUhuVUxRVXVvMk93d2dh?=
 =?utf-8?B?QVhqdXRRUTMzbDE1UitDL25CMnJ3QW9TY3RZbE1zdTloWlZGVW5YOWZGNDIr?=
 =?utf-8?B?NGx2WmN6RGc0VEV6Y3NmZG5VSzFMcURsVVN6ZC8xck55YnBYZU5QVnZkR3hW?=
 =?utf-8?B?WGt4TmNLOCtQbFp4TDN6TzlMc2xCWnhNZnhnemgvS3VLZVAyaUJFc0ZnNEFM?=
 =?utf-8?B?b05Ga0xObHR6SUt3T3dBdlJZT2lrRjVJQ0liWDBxNlhsMnJnTmVnWW9NVnhI?=
 =?utf-8?B?UHl1WkhCRFJSR1owWWtUMXNmVktzODVwYmVnSVhubHEwNTlGOSttZStyWDFx?=
 =?utf-8?B?cXpWY2xrczlGeGtVdTFCanRFeS9QWjNhT2NTY3lEMlBoOGNUUzBBQnNMRHpo?=
 =?utf-8?B?QVZDMFhaODhLSW9NbDMwZDRwQlRudldZRVhOQ3gybXMwNFZacG5pWlV5TUFO?=
 =?utf-8?B?eDUrRmduZ1hMMUpiWDA4WW9KSXBZbUM1emFCKzJXbDd0dCtoendMdXpmVG1l?=
 =?utf-8?B?U2IrL2xQNXcxUXRMREdVR1hOcklNWHZCcmd4UExsbE03dStGc09KNE0wa1o0?=
 =?utf-8?B?aVowaWk1YzhSZE1YT01zd3hFa1JZV2xGaGNORFJicUgzZGRSY3VwVUZ6UDJw?=
 =?utf-8?B?SHFsRU1CcUZMT0t6cXdSby9naWtZUjRNaVVobk5SMnp5VkJnbXFaUDRGUHRG?=
 =?utf-8?B?VnZPTjBwN25PdVlDRVUrbG16V1Vxck9DYWMxZ1dQbU1DVTdOTjY4RmZydE5D?=
 =?utf-8?B?bEduWllXU3R0VUxTSisxLyttUnRkYSszeWIwRGJIeG5mZ2hnMTZ1YXZZTmtJ?=
 =?utf-8?B?dlhvN1pkNzFoaVZRZGx1TnpTYTAwVlk0Q2FwNUJZVUlvcHBZSERqbGwybzZR?=
 =?utf-8?B?YWg2cSs3R0NLQlhzNDUreElBR241L1FrNXJYS24wRzFqczd2NVdxTVoxQVZM?=
 =?utf-8?B?aVRucEozaUNaeldRbXp2eTUzZG01bERpZzVpQ1l4TGxXd1dkNTJ6OGlvLzVr?=
 =?utf-8?B?K1c1aXkycWJ2dFhSbmFuaWIrT0pqNG16dXFWSS9vOVhwSW1wK0VUdXFnaTRo?=
 =?utf-8?B?VjdwRzNRSDZhR2VLRTFTUk93Qmxxb0NvYlVwZlI4Y2tCRDZ4OFVpK2ljd1hE?=
 =?utf-8?B?OC94a0FIZTY1RFczUHE4d296dGIyVHZIdnROSGwvSDUwa0p1UzRxVEZWdjZr?=
 =?utf-8?B?K0o0cFdwcmFIVmhiV0o0S2UrV1A0REx2T1N0SnJvZzVSamRIbk5YZnhaQ0lv?=
 =?utf-8?B?UjhpOUhja1NmL2JpNTJkTnQ1U0RrcXdpQnBSVWZVUVhtdy9qOFJFeFZ1dW1l?=
 =?utf-8?B?VE9KM2FBZUpxTWFuWmR2QUZyTnM0b2lsZ1hNaW5MOXNFUWhzRUcvMngydzhB?=
 =?utf-8?B?ZEpueXQ0SDFoV1E0cDNKcVJnUVZlM3B5WlQycXE1T2hFZGJub1RlZjRTbXFB?=
 =?utf-8?B?em9LdUxRNUlMS2laZEtDRXpBenY4c2MzbkhScHU5QXd4TzRWL0cxVVdXc01F?=
 =?utf-8?Q?XrL3eXtLyoSskDcfqZ+NXqEYP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OqLg+xMp6QcwEzC2+KtfuKnGTYsdzl5wYRqbHjcEFuXuMBkHHSFjIyUyMO7G1S2ZCuTt5XnV0pzrHO73TC2w8DL3C/AVnFCXhv6YPYMrtQEmmtTbtUYrOu1SEA6TCHqJ8mgaT/LDxe4oD63r9+eAsVIkF1t68VkMsRS+yd/iYSVtPYBZJScpIdAx7x0I2WUvOjHQpEjcDLx9aVE/5qsb5BipmnEkV550o+cLaaAKDFj643gGGNkGWGH+gKz5reNNk38WG/jyzbQMPJn8xcFWFztvibU8FtrInILz1XxtIF9WCLSDsMyeX9J2iyfGHAsMGccgwAkyaBPA6WonXQneuTUTgrfuPKCqEFRkY/duipk3i5bGkKAQfGcvZMTRTQBHIhqP0UWQtxtrCIGzWjOoFqSQMUBmjKHB/RrAirfmepqk5kgDQloKqTf7cW7xoIa4C3oOotUs5Vau6MJxDv8RfjxXv2WWyixE+qyrpnBI9Sa4n1bUW651wrzOSwBPRnFJImoc8OTr8R6qQ1+n3fczyUWi8F9gavH+ui8Mm422M//AbC4I3oDCNZ7setx+Z8oo0D2cmAHRl0AWn8SE7RLt/Ktt0BgzhPIeE7yYhXCMgjLBK4AzIxtNF5dt9MMw+AJX
X-OriginatorOrg: uwaterloo.ca
X-MS-Exchange-CrossTenant-Network-Message-Id: 395a768c-01f0-40f6-cfe3-08dcfabe9782
X-MS-Exchange-CrossTenant-AuthSource: YQXPR01MB6575.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 21:46:07.4279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 723a5a87-f39a-4a22-9247-3fc240c01396
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tejOXrMk2XSbUXCqJnSTW7QXcEYWLT+qfVMQ2Xv+VlXWHjmkKfTK3bhP3zqSwgLPDdQ/g2NsfcIm57gPHTIoag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5624

On 2024-11-01 17:01, Samudrala, Sridhar wrote:
> 
> 
> On 10/31/2024 11:39 PM, Joe Damato wrote:
>> On Thu, Oct 31, 2024 at 10:47:05PM -0500, Samudrala, Sridhar wrote:
>>>
>>>
>>> On 10/31/2024 7:48 PM, Joe Damato wrote:
>>>> Describe irq suspension, the epoll ioctls, and the tradeoffs of using
>>>> different gro_flush_timeout values.

[...]

>>>> +To use this mechanism:
>>>> +
>>>> +  1. The per-NAPI config parameter ``irq_suspend_timeout`` should 
>>>> be set to the
>>>> +     maximum time (in nanoseconds) the application can have its IRQs
>>>> +     suspended. This is done using netlink, as described above. 
>>>> This timeout
>>>> +     serves as a safety mechanism to restart IRQ driver interrupt 
>>>> processing if
>>>> +     the application has stalled. This value should be chosen so 
>>>> that it covers
>>>> +     the amount of time the user application needs to process data 
>>>> from its
>>>> +     call to epoll_wait, noting that applications can control how 
>>>> much data
>>>> +     they retrieve by setting ``max_events`` when calling epoll_wait.
>>>> +
>>>> +  2. The sysfs parameter or per-NAPI config parameters 
>>>> ``gro_flush_timeout``
>>>> +     and ``napi_defer_hard_irqs`` can be set to low values. They 
>>>> will be used
>>>> +     to defer IRQs after busy poll has found no data.
>>>
>>> Is it required to set gro_flush_timeout and napi_defer_hard_irqs when
>>> irq_suspend_timeout is set? Doesn't it override any smaller
>>> gro_flush_timeout value?
>>
>> It is not required to use gro_flush_timeout or napi_defer_hard_irqs,
>> but if they are set they will take over when epoll finds no events.
>> Their usage is recommended. See the Usage section of the cover
>> letter for details.
>>
>> While gro_flush_timeout and napi_defer_hard_irqs are not strictly
>> required, it is difficult for the polling-based packet delivery loop
>> to gain control over packet delivery.
>>
>> Please see a previous email about this from the RFC for more
>> details:
>>
>> https://lore.kernel.org/netdev/2bb121dd-3dcd-4142- 
>> ab87-02ccf4afd469@uwaterloo.ca/
> 
> OK. Thanks for the clarification.
>>
>> In the cover letter, you can note the difference in performance when
>> gro_flush_timeout is set to different values. Note the explanation
>> of suspendX; each suspend case is testing a different
>> gro_flush_timeout.
> 
> May be you can also include a test scenario in your perf results  where 
> gro_flush_timeout and napi_defer_hard_irqs are not set to show that a 
> non-zero value of gro_flush_timeout and napi_defer_hard_irqs is 
> recommended when using irq_suspend_timeout.

Thanks for your feedback. We've updated the cover letter as well as the 
kernel documentation to explain this in more detail and to illustrate 
why the parameter usage is recommended. We ran experiments with these 
parameters set to zero and the results are as expected and essentially 
the same as the base case, i.e., irq_suspend_timeout does not have an 
effect in this case.

Thanks,
Martin



> 
>>
>> Let us know if you have any other questions; both Martin and I are
>> happy to help or further explain anything that is not clear.
>>
> 


